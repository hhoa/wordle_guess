import 'package:get/get.dart';
import 'package:wordle_guess/src/constant/constant.dart';

import '../../enum/box.dart';
import '../../model/box.dart';

class HomeController extends GetxController {
  Map<String, BoxType> keyboardMap = {};

  RxList<Boxes> listBoxes = RxList();

  int get puzzleCount => listBoxes.length;

  @override
  void onInit() {
    super.onInit();

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
    final Boxes lastBox = listBoxes[puzzleCount - 1];
    if (key == WordleConstant.delText) {
      final int lastNotEmptyIndex =
          lastBox.lastIndexWhere((box) => box.char != null);
      if (lastNotEmptyIndex == -1) {
        return;
      }

      listBoxes[puzzleCount - 1][lastNotEmptyIndex] = Box(char: null);
      listBoxes.refresh();
    } else {
      final int firstEmptyIndex = lastBox.indexWhere((box) => box.char == null);
      if (firstEmptyIndex == -1) {
        return;
      }

      listBoxes[puzzleCount - 1][firstEmptyIndex] = Box(char: key);
      listBoxes.refresh();
    }
  }
}
