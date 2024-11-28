import 'package:flutter/material.dart' show FontWeight, TextStyle;

import 'colors.dart';

class WordleTypographyTheme extends TextStyle {
  static const String baseFontFamily = 'Comfortaa';

  static final TextStyle _base =
      TextStyle(fontFamily: baseFontFamily, color: WordleColors.white);

  static final textStyleRegular = _base.copyWith(fontWeight: FontWeight.w400);

  static final textStyleLight = _base.copyWith(fontWeight: FontWeight.w300);

  static final textStyleMedium = _base.copyWith(fontWeight: FontWeight.w500);

  static final textStyleSemiBold = _base.copyWith(fontWeight: FontWeight.w600);

  static final textStyleBold = _base.copyWith(fontWeight: FontWeight.w700);
}
