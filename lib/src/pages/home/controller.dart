import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wordle_guess/src/constant/constant.dart';
import 'package:wordle_guess/src/constant/keys.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/utils/dialog.dart';

import '../../domain/entities/guess/guess.dart';
import '../../domain/usecases/bot_guess_usecase.dart';
import '../../domain/usecases/get_guess_usecase.dart';
import '../../enum/box.dart';
import '../../enum/button.dart';
import '../../model/box.dart';

class HomeController extends GetxController {
  HomeController(
    this.getGuessUsecase,
    this.botGuessUsecase,
  );

  final GetGuessUsecase getGuessUsecase;
  final BotGuessUsecase botGuessUsecase;

  final GetStorage storage = GetStorage();

  final RxInt _level = 1.obs;

  int get level => _level.value;

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

    _level.value = storage.read<int>(WordleKeys.appLatestLevel) ?? 1;
    addDefaultRowBoxes();
  }

  void addDefaultRowBoxes() {
    listBoxes.add(List<Box>.generate(
        WordleConstant.numberOfBox, (_) => Box(type: BoxType.none)).toList());
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
        storage.read<bool>(WordleKeys.showFirstTimeTutorial) ?? false;
    if (!firstTimeTutorial) {
      WordleDialog.showTutorial();
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

    if (latestBoxes[WordleConstant.numberOfBox - 1].char != null) {
      _submitButtonType.value = ButtonType.enabled;
    } else {
      _submitButtonType.value = ButtonType.disabled;
    }
  }

  void onSubmitted() async {
    _submitButtonType.value = ButtonType.loading;
    final String guess = latestBoxes.map((box) => box.char!).join();
    try {
      final List<GuessResponse> results = await getGuessUsecase.guessRandom(
          guess: guess, size: WordleConstant.numberOfBox, seed: _level.value);
      final int minLength = min(results.length, WordleConstant.numberOfBox);
      for (int i = 0; i < minLength; i++) {
        final GuessResponse result = results[i];
        final String guess = result.guess.toUpperCase();
        final BoxType type = result.type;
        final int slot = result.slot;
        if (guess == latestBoxes[i].char) {
          final Box newBox = Box(char: guess, type: type, slot: slot);
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
      if (successfulBoxes == WordleConstant.numberOfBox) {
        WordleDialog.showSuccessDialog(
            correctWord: latestBoxes,
            onNext: () {
              _level.value = _level.value + 1;
              storage.write(WordleKeys.appLatestLevel, level);
              keyboardMap.clear();
              keyboardMap.refresh();
              listBoxes.clear();
              listPuzzleKey.currentState!
                  .removeAllItems((_, __) => const SizedBox());
              addDefaultRowBoxes();
              Get.back();
            });
      } else {
        addDefaultRowBoxes();
      }
    } catch (e) {
      _submitButtonType.value = ButtonType.disabled;
      WordleDialog.showError(e.toString());
    }
  }

  void onBotGuess() async {
    if (submitButtonType == ButtonType.loading) {
      return;
    }

    _submitButtonType.value = ButtonType.loading;
    final String? botGuessResult =
        await botGuessUsecase.takeGuess(keyMap: keyboardMap);
    final String? formattedResult = botGuessResult?.trim().toUpperCase();
    if (formattedResult != null &&
        formattedResult.length == WordleConstant.numberOfBox) {
      final List<String> guessChars = formattedResult.split('');
      listBoxes[puzzleCount - 1] =
          guessChars.map((char) => Box(char: char)).toList();
      listBoxes.refresh();
      onSubmitted();
    } else {
      _submitButtonType.value = ButtonType.disabled;
      WordleDialog.showError(WordleText.botHasError);
    }
  }
}
