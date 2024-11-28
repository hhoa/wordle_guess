import 'package:flutter/animation.dart' show Color;
import 'package:flutter/material.dart';

import '../resources/colors.dart';

enum BoxType {
  none,
  notExist,
  existWithCorrectPosition,
  existWithIncorrectPosition,
}

extension BoxExt on BoxType {
  String get param {
    switch (this) {
      case BoxType.none:
        return '';
      case BoxType.notExist:
        return 'absent';
      case BoxType.existWithCorrectPosition:
        return 'correct';
      case BoxType.existWithIncorrectPosition:
        return 'present';
    }
  }

  Color get boxBorderColor {
    switch (this) {
      case BoxType.none:
        return WordleColors.white;
      case BoxType.notExist:
        return WordleColors.grey;
      case BoxType.existWithIncorrectPosition:
        return WordleColors.yellow;
      case BoxType.existWithCorrectPosition:
        return WordleColors.green;
    }
  }

  Color? get boxBgColor {
    switch (this) {
      case BoxType.none:
        return null;
      case BoxType.notExist:
        return WordleColors.grey;
      case BoxType.existWithIncorrectPosition:
        return WordleColors.yellow;
      case BoxType.existWithCorrectPosition:
        return WordleColors.green;
    }
  }

  Color get keyboardBgColor {
    switch (this) {
      case BoxType.none:
        return WordleColors.white;
      case BoxType.notExist:
        return WordleColors.grey;
      case BoxType.existWithIncorrectPosition:
        return WordleColors.yellow;
      case BoxType.existWithCorrectPosition:
        return WordleColors.green;
    }
  }

  Color get keyboardColor {
    switch (this) {
      case BoxType.none:
        return WordleColors.purple;
      case BoxType.notExist:
      case BoxType.existWithIncorrectPosition:
      case BoxType.existWithCorrectPosition:
        return WordleColors.white;
    }
  }
}
