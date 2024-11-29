import 'package:wordle_guess/src/domain/entities/guess/guess.dart';

import '../enum/box.dart';

typedef Boxes = List<Box>;

class Box {
  Box({this.type = BoxType.none, this.char, this.slot});

  late final BoxType type;
  late final String? char;
  late final int? slot;

  Box.fromSource(GuessResponse guess) {
    type = guess.type;
    char = guess.guess.toUpperCase();
    slot = guess.slot;
  }
}
