import 'package:test/test.dart';
import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/enum/box.dart';

void main() {
  test('can set', () {
    final GuessResponse absentBean = GuessResponseSample.createAbsent();
    expect(absentBean.guess, 'h');
    expect(absentBean.slot, 0);
    expect(absentBean.type, BoxType.notExist);
  });
}

class GuessResponseSample {
  GuessResponseSample();

  static GuessResponse createAbsent() =>
      GuessResponse(guess: 'h', slot: 0, type: BoxType.notExist);
}
