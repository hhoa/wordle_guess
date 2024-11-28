import 'package:get/get.dart';

class WordleCommon {
  static double calculateWidth({
    required int numberOfItems,
    required double horizontalPadding,
    required double spacer,
  }) {
    const double spacer = 2;
    final double screenWidth = Get.width;
    final double paddingSpacer = (numberOfItems - 1) * spacer;
    return (screenWidth - horizontalPadding - paddingSpacer) / numberOfItems;
  }
}
