import 'package:flutter/material.dart' show Color;
import 'package:wordle_guess/src/resources/colors.dart';

enum Level {
  easy, medium, hard
}

extension LevelExt on Level {
  String get text => name.toUpperCase();

  int get numberOfBox {
    switch (this) {
      case Level.easy:
        return 4;
      case Level.medium:
        return 5;
      case Level.hard:
        return 6;
    }
  }

  Color get bgColor {
    switch (this) {
      case Level.easy:
        return WordleColors.primaryColorEasy;
      case Level.medium:
        return WordleColors.primaryColorMedium;
      case Level.hard:
        return WordleColors.primaryColorHard;
    }
  }

  Color get dialogBgColor {
    switch (this) {
      case Level.easy:
        return WordleColors.easyDialogBgColor;
      case Level.medium:
        return WordleColors.mediumDialogBgColor;
      case Level.hard:
        return WordleColors.hardDialogBgColor;
    }
  }

  Color get submitButtonColor {
    switch (this) {
      case Level.easy:
        return WordleColors.easySubmitButtonColor;
      case Level.medium:
        return WordleColors.mediumSubmitButtonColor;
      case Level.hard:
        return WordleColors.hardSubmitButtonColor;
    }
  }

  Color get botGuessButtonColor {
    switch (this) {
      case Level.easy:
        return WordleColors.easyBotGuessButtonColor;
      case Level.medium:
        return WordleColors.mediumBotGuessButtonColor;
      case Level.hard:
        return WordleColors.hardBotGuessButtonColor;
    }
  }
}