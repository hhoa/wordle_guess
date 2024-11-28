import 'dart:math';

import 'package:get/get.dart';
import 'package:wordle_guess/src/constant/constant.dart';

import '../../domain/entities/guess/guess.dart';
import '../../domain/usecases/guess_usecase.dart';
import '../../enum/box.dart';
import '../../enum/button.dart';
import '../../model/box.dart';

class HomeController extends GetxController {
  HomeController(this.getGuessUsecase);

  final GetGuessUsecase getGuessUsecase;

  int level = 1;
  RxMap<String, BoxType> keyboardMap = RxMap();

  RxList<Boxes> listBoxes = RxList();

  int get puzzleCount => listBoxes.length;

  Boxes get latestBoxes => listBoxes[puzzleCount - 1];

  final Rx<ButtonType> _submitButtonType = ButtonType.disabled.obs;

  ButtonType get submitButtonType => _submitButtonType.value;

  @override
  void onInit() {
    super.onInit();

    addDefaultRowBoxes();
  }

  void addDefaultRowBoxes() {
    listBoxes.add(List<Box>.generate(
        WordleConstant.numberOfBox, (_) => Box(type: BoxType.none)).toList());
  }

  BoxType getKeyType(String key) {
    if (keyboardMap.containsKey(key)) {
      return keyboardMap[key]!;
    }

    return BoxType.none;
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
          guess: guess, size: WordleConstant.numberOfBox, seed: level);
      final int minLength = min(results.length, WordleConstant.numberOfBox);
      for (int i = 0; i < minLength; i++) {
        final GuessResponse result = results[i];
        final String guess = result.guess.toUpperCase();
        final BoxType type = result.type;
        if (guess == latestBoxes[i].char) {
          listBoxes[puzzleCount - 1][i] = Box(char: guess, type: type);
          if (keyboardMap.containsKey(guess)) {
            final BoxType currentType = keyboardMap[guess]!;
            if (type != BoxType.none &&
                type != BoxType.notExist &&
                currentType != BoxType.existWithCorrectPosition) {
              keyboardMap[guess] = type;
              keyboardMap.refresh();
            }
          } else {
            keyboardMap[guess] = type;
            keyboardMap.refresh();
          }
        }
      }

      _submitButtonType.value = ButtonType.disabled;
      final int successfulBoxes = latestBoxes
          .where((box) => box.type == BoxType.existWithCorrectPosition)
          .toList().length;
      if (successfulBoxes == WordleConstant.numberOfBox) {
        // success
      } else {
        addDefaultRowBoxes();
      }
      listBoxes.refresh();
    } catch (e) {
      _submitButtonType.value = ButtonType.disabled;
    }
  }
}
