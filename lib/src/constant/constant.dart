import 'package:wordle_guess/src/model/splash.dart';
import 'package:wordle_guess/src/resources/colors.dart';

class WordleConstant {
  static final List<SplashChar> splashChars = [
    SplashChar(char: 'W', color: WordleColors.purple),
    SplashChar(char: 'O', color: WordleColors.green),
    SplashChar(char: 'R', color: WordleColors.blue),
    SplashChar(char: 'D', color: WordleColors.yellow),
    SplashChar(char: 'L', color: WordleColors.lightPurple),
    SplashChar(char: 'E', color: WordleColors.shadow),
  ];

  static const double horizontalPuzzlePadding = 60;

  static const String delText = 'DEL';

  static const List<List<String>> alphabetKeys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M', WordleConstant.delText],
  ];

  static const double borderRadius = 8;

  static const Duration animationDuration = Duration(milliseconds: 200);

  static const String geminiModel = 'gemini-1.5-flash';
}
