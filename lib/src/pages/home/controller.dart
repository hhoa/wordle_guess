import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wordle_guess/src/constant/constant.dart';
import 'package:wordle_guess/src/constant/preference_keys.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/utils/dialog.dart';

import '../../domain/entities/guess/guess.dart';
import '../../domain/usecases/bot_guess_usecase.dart';
import '../../domain/usecases/get_guess_usecase.dart';
import '../../enum/box.dart';
import '../../enum/button.dart';
import '../../enum/level.dart';
import '../../model/box.dart';

class HomeController extends GetxController {
  HomeController(
    this.getGuessUsecase,
    this.botGuessUsecase,
  );

  final GetGuessUsecase getGuessUsecase;
  final BotGuessUsecase botGuessUsecase;

  final GetStorage storage = GetStorage();

  final Rx<Level> _level = Level.medium.obs;

  Level get level => _level.value;

  int get numberOfBox => level.numberOfBox;

  final RxInt _stage = 1.obs;

  int get stage => _stage.value;

  RxMap<String, Boxes> keyboardMap = RxMap<String, Boxes>();

  RxList<Boxes> listBoxes = RxList();

  int get puzzleCount => listBoxes.length;

  Boxes get latestBoxes => listBoxes[puzzleCount - 1];

  final Rx<ButtonType> _submitButtonType = ButtonType.disabled.obs;

  GlobalKey<AnimatedListState> listPuzzleKey = GlobalKey<AnimatedListState>();

  final ScrollController scrollController = ScrollController();

  ButtonType get submitButtonType => _submitButtonType.value;

  @override
  void onInit() {
    super.onInit();

    _initVar();
    _addDefaultRowBoxes();
  }

  void _initVar() {
    _stage.value = storage.read<int>(WordlePreferenceKeys.appLatestStage) ?? 1;
    final String savedLvl =
        storage.read<String>(WordlePreferenceKeys.appLevel) ??
            Level.medium.text;
    _level.value = Level.values.firstWhere((lvl) => lvl.text == savedLvl);
  }

  void _addDefaultRowBoxes() {
    listBoxes.add(
        List<Box>.generate(numberOfBox, (_) => Box(type: BoxType.none))
            .toList());
    listPuzzleKey.currentState?.insertItem(puzzleCount - 1);
    if (scrollController.hasClients) {
      Future.delayed(WordleConstant.animationDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: WordleConstant.animationDuration, curve: Curves.linear);
      });
    }
  }

  @override
  void onReady() {
    super.onReady();

    final firstTimeTutorial =
        storage.read<bool>(WordlePreferenceKeys.showFirstTimeTutorial) ?? false;
    if (!firstTimeTutorial) {
      WordleDialog.showTutorial(level, numberOfBox);
    }
  }

  void inputKey(String key) {
    if (key == WordleConstant.delText) {
      final int lastNotEmptyIndex =
          latestBoxes.lastIndexWhere((box) => box.char != null);
      if (lastNotEmptyIndex == -1) {
        return;
      }

      listBoxes[puzzleCount - 1][lastNotEmptyIndex] = Box(char: null);
      listBoxes.refresh();
    } else {
      final int firstEmptyIndex =
          latestBoxes.indexWhere((box) => box.char == null);
      if (firstEmptyIndex == -1) {
        return;
      }

      listBoxes[puzzleCount - 1][firstEmptyIndex] = Box(char: key);
      listBoxes.refresh();
    }

    if (latestBoxes[numberOfBox - 1].char != null) {
      _submitButtonType.value = ButtonType.enabled;
    } else {
      _submitButtonType.value = ButtonType.disabled;
    }
  }

  void onSubmitted() async {
    _submitButtonType.value = ButtonType.loading;
    final String guess = latestBoxes.map((box) => box.char!).join();
    try {
      final List<GuessResponse> results = await getGuessUsecase.run(
          guess: guess, size: numberOfBox, seed: _stage.value);
      final int minLength = min(results.length, numberOfBox);
      for (int i = 0; i < minLength; i++) {
        final GuessResponse result = results[i];
        final String guess = result.guess.toUpperCase();
        final BoxType type = result.type;
        final int slot = result.slot;
        if (guess == latestBoxes[i].char) {
          final Box newBox = Box.fromSource(result);
          listBoxes[puzzleCount - 1][i] = newBox;

          if (keyboardMap.containsKey(guess)) {
            final BoxType currentType = keyboardMap[guess]!.first.type;
            if (type == BoxType.existWithIncorrectPosition) {
              if (currentType == BoxType.existWithIncorrectPosition) {
                final List<int?> currentSlots =
                    keyboardMap[guess]!.map((map) => map.slot).toList();
                if (!currentSlots.contains(slot)) {
                  keyboardMap[guess]!.add(newBox);
                }
              }
            } else if (type == BoxType.existWithCorrectPosition) {
              if (currentType == BoxType.existWithCorrectPosition) {
                final List<int?> currentSlots =
                    keyboardMap[guess]!.map((map) => map.slot).toList();
                if (!currentSlots.contains(slot)) {
                  keyboardMap[guess]!.add(newBox);
                }
              } else {
                keyboardMap[guess] = [newBox];
              }
            }
          } else {
            keyboardMap[guess] = [newBox];
          }
          keyboardMap.refresh();
        }
      }

      _submitButtonType.value = ButtonType.disabled;
      final int successfulBoxes = latestBoxes
          .where((box) => box.type == BoxType.existWithCorrectPosition)
          .toList()
          .length;
      if (successfulBoxes == numberOfBox) {
        WordleDialog.showSuccessDialog(level,
            correctWord: latestBoxes, numberOfBox: numberOfBox, onNext: () {
          _stage.value = _stage.value + 1;
          storage.write(WordlePreferenceKeys.appLatestStage, stage);
          _clearMap();
          Get.back();
        });
      } else {
        _addDefaultRowBoxes();
      }
    } catch (e) {
      _submitButtonType.value = ButtonType.disabled;
      WordleDialog.showError(e.toString());
    }
  }

  void _clearMap() {
    keyboardMap.clear();
    keyboardMap.refresh();
    listBoxes.clear();
    listPuzzleKey.currentState!.removeAllItems((_, __) => const SizedBox());
    _submitButtonType.value = ButtonType.disabled;
    _addDefaultRowBoxes();
  }

  void onBotGuess() async {
    if (submitButtonType == ButtonType.loading) {
      return;
    }

    _submitButtonType.value = ButtonType.loading;
    final String? botGuessResult =
        await botGuessUsecase.run(numberOfBox, keyMap: keyboardMap);
    if (botGuessResult != null && botGuessResult.length == numberOfBox) {
      final List<String> guessChars = botGuessResult.split('');
      listBoxes[puzzleCount - 1] =
          guessChars.map((char) => Box(char: char)).toList();
      listBoxes.refresh();
      onSubmitted();
    } else {
      _submitButtonType.value = ButtonType.disabled;
      WordleDialog.showError(WordleText.botHasError);
    }
  }

  void updateLevel(Level newLevel) {
    _level.value = newLevel;
    storage.write(WordlePreferenceKeys.appLevel, newLevel.text);
    _clearMap();
    update();
  }
}
