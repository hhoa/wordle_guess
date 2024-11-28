class WordleConstant {
  static const int numberOfBox = 5;

  static const int horizontalPuzzlePadding = 60;

  static const String delText = 'DEL';

  static const List<List<String>> alphabetKeys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M', WordleConstant.delText],
  ];

  static const double borderRadius = 8;

  static const Duration animationDuration = Duration(milliseconds: 200);
}
