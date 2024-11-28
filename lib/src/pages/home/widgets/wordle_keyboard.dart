import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/borders.dart';
import '../../../constant/constant.dart';
import '../../../enum/box.dart';
import '../../../resources/typography.dart';
import '../../../utils/common.dart';
import '../controller.dart';

class WordleKeyboard extends GetView<HomeController> {
  const WordleKeyboard({super.key});

  final double spacer = 2;

  @override
  Widget build(BuildContext context) {
    final int numberOfChars = WordleConstant.alphabetKeys.first.length;
    final double boxWidth = WordleCommon.calculateWidth(
        numberOfItems: numberOfChars, horizontalPadding: 8, spacer: spacer);
    final double boxHeight = boxWidth * 4 / 3;

    return Column(
      children: WordleConstant.alphabetKeys.map((keys) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: _buildKeysRow(keys, boxWidth, boxHeight),
        );
      }).toList(),
    );
  }

  Widget _buildKeysRow(List<String> keys, double boxWidth, double boxHeight) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacer,
      children: keys.map((key) {
        return _buildKey(key, boxWidth, boxHeight);
      }).toList(),
    );
  }

  Widget _buildKey(String key, double boxWidth, double boxHeight) {
    final BoxType type = controller.getKeyType(key);
    final bool isDel = key == WordleConstant.delText;

    return SizedBox(
      width: isDel ? (boxWidth * 1.6) : boxWidth,
      height: boxHeight,
      child: ElevatedButton(
        onPressed: () {
          controller.inputKey(key);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: WordleBorders.radiusL,
          ),
        ),
        child: isDel
            ? Icon(
                Icons.cancel_presentation_rounded,
                color: type.keyboardColor,
              )
            : Text(
                key,
                style: WordleTypographyTheme.textStyleSemiBold
                    .copyWith(fontSize: 16, color: type.keyboardColor),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
