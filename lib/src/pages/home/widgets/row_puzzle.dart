import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/box.dart';

import '../../../constant/constant.dart';
import '../../../model/box.dart';
import '../../../resources/typography.dart';

class RowPuzzle extends GetView {
  const RowPuzzle({
    required this.boxes,
    super.key,
  });

  final List<Box> boxes;

  int get numberOfBox => boxes.length;

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacer = 8;
    final double screenWidth = Get.width;
    final double paddingSpacer = (numberOfBox - 1) * horizontalSpacer;
    final double boxWidth =
        (screenWidth - WordleConstant.horizontalPuzzlePadding - paddingSpacer) /
            numberOfBox;

    return Wrap(
      spacing: horizontalSpacer,
      alignment: WrapAlignment.center,
      children: boxes.map((box) => _buildBox(boxWidth, box)).toList(),
    );
  }

  Widget _buildBox(double boxWidth, Box box) {
    return AnimatedContainer(
      duration: WordleConstant.animationDuration,
      width: boxWidth,
      height: boxWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: box.type.boxBorderColor, width: 3),
          color: box.type.boxBgColor),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3),
      child: AnimatedCrossFade(
        firstChild: const SizedBox(),
        secondChild: Text(
          box.char ?? '',
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
