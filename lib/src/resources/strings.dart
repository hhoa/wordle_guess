class WordleText {
  static const String level = 'LEVEL';
  static const String submit = 'SUBMIT';
  static const String botHasError = 'Bot cannot take guess now';
  static const String somethingWentWrong = 'Something went wrong';
  static const String tryAgainLater = 'Please try again later';
  static const String howToPlay = 'HOW TO PLAY';
  static String instruction(int number) =>
      'Use the on-screen keyboard to type a $number-letter word.\n\nOnce you\'ve entered all $number letters, press the SUBMIT button to make your guess.';
  static const String correctDescription =
      'The letter is correct and in the right position.';
  static const String presentDescription =
      'The letter is in the word but in the wrong position.';
  static const String absentDescription =
      'The letter is not in the word at all.';
  static const String congrats = 'CONGRATS';
  static const String settings = 'SETTINGS';
  static const String clearedLevel = 'You cleared this level with word';
  static const String okay = 'OKAY';
  static const String next = 'NEXT';
}
