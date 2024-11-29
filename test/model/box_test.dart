import 'package:test/test.dart';
import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/model/box.dart';

import '../domain/entities/guess/guess_test.dart';

void main() {
  test('can set', () {
    final Box model = BoxSample.create();

    expect(model.char, 'h');
    expect(model.type, BoxType.notExist);
    expect(model.slot, 0);
  });

  test('can convert from source', () {
    final GuessResponse source = GuessResponseSample.createAbsent();
    final Box model = Box.fromSource(source);

    expect(model.char, 'h'.toUpperCase());
    expect(model.type, BoxType.notExist);
    expect(model.slot, 0);
  });
}

class BoxSample {
  BoxSample();

  static Box create() => Box(
        type: BoxType.notExist,
        char: 'h',
        slot: 0,
      );
}
