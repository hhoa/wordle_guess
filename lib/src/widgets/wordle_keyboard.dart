import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/borders.dart';
import '../constant/constant.dart';
import '../enum/box.dart';
import '../model/box.dart';
import '../resources/typography.dart';
import '../utils/common.dart';

class WordleKeyboard extends GetView {
  const WordleKeyboard({
    required this.keyboardMap,
    required this.onPressed,
    super.key,
  });

  final Map<String, Boxes> keyboardMap;
  final Function(String key)? onPressed;
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

  BoxType getKeyboardType(String key) {
    BoxType type = BoxType.none;
    if (keyboardMap.containsKey(key)) {
      type = keyboardMap[key]!.first.type;
    }
    return type;
  }

  Widget _buildKey(String key, double boxWidth, double boxHeight) {
    BoxType type = getKeyboardType(key);
    final bool isDel = key == WordleConstant.delText;

    return SizedBox(
      width: isDel ? (boxWidth * 1.6) : boxWidth,
      height: boxHeight,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!(key);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: WordleBorders.radiusL,
          ),
          backgroundColor: type.keyboardBgColor,
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
