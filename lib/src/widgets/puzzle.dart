import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/box.dart';

import '../constant/borders.dart';
import '../constant/constant.dart';
import '../model/box.dart';
import '../resources/typography.dart';
import '../utils/common.dart';

class Puzzle extends GetView {
  const Puzzle({required this.box, required this.numberOfBox, super.key});

  final Box box;
  final int numberOfBox;

  @override
  Widget build(BuildContext context) {
    final double boxWidth = WordleCommon.calculateWidth(
        numberOfItems: numberOfBox,
        horizontalPadding: WordleConstant.horizontalPuzzlePadding,
        spacer: 8);

    return AnimatedContainer(
      duration: WordleConstant.animationDuration,
      width: boxWidth,
      height: boxWidth,
      decoration: BoxDecoration(
          borderRadius: WordleBorders.radiusL,
          border: Border.all(color: box.type.boxBorderColor, width: 3),
          color: box.type.boxBgColor),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3),
      child: AnimatedCrossFade(
        firstChild: const SizedBox(),
        secondChild: Text(
          box.char?.toUpperCase() ?? '',
          style: WordleTypographyTheme.textStyleBold.copyWith(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        crossFadeState: box.char == null
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: WordleConstant.animationDuration,
      ),
    );
  }
}
