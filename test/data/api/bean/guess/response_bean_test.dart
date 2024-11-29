import 'package:test/test.dart';
import 'package:wordle_guess/src/data/api/bean/guess/response_bean.dart';
import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/enum/box.dart';

void main() {
  test('can create from json', () {
    final GuessResponseBean absentBean =
        GuessResponseBeanSample.createAbsentFromJson();
    expect(absentBean.guess, 'h');
    expect(absentBean.slot, 0);
    expect(absentBean.result, BoxType.notExist.param);

    final GuessResponseBean correctBean =
        GuessResponseBeanSample.createCorrectFromJson();
    expect(correctBean.guess, 'o');
    expect(correctBean.slot, 1);
    expect(correctBean.result, BoxType.existWithCorrectPosition.param);

    final GuessResponseBean presentBean =
        GuessResponseBeanSample.createPresentFromJson();
    expect(presentBean.guess, 'u');
    expect(presentBean.slot, 2);
    expect(presentBean.result, BoxType.existWithIncorrectPosition.param);
  });

  test('toEntity', () {
    final GuessResponseBean absentBean =
        GuessResponseBeanSample.createAbsentFromJson();
    final GuessResponse absent = absentBean.toEntity();
    expect(absent.guess, 'h');
    expect(absent.slot, 0);
    expect(absent.type, BoxType.notExist);

    final GuessResponseBean correctBean =
        GuessResponseBeanSample.createCorrectFromJson();
    final GuessResponse correct = correctBean.toEntity();
    expect(correct.guess, 'o');
    expect(correct.slot, 1);
    expect(correct.type, BoxType.existWithCorrectPosition);

    final GuessResponseBean presentBean =
        GuessResponseBeanSample.createPresentFromJson();
    final GuessResponse present = presentBean.toEntity();
    expect(present.guess, 'u');
    expect(present.slot, 2);
    expect(present.type, BoxType.existWithIncorrectPosition);
  });
}

class GuessResponseBeanSample {
  GuessResponseBeanSample();

  static Map<String, dynamic> absentJson() => <String, dynamic>{
        'slot': 0,
        'guess': 'h',
        'result': 'absent',
      };

  static Map<String, dynamic> correctJson() => <String, dynamic>{
        'slot': 1,
        'guess': 'o',
        'result': 'correct',
      };

  static Map<String, dynamic> presentJson() => <String, dynamic>{
        'slot': 2,
        'guess': 'u',
        'result': 'present',
      };

  static GuessResponseBean createAbsentFromJson() =>
      GuessResponseBean.fromJson(absentJson());

  static GuessResponseBean createCorrectFromJson() =>
      GuessResponseBean.fromJson(correctJson());

  static GuessResponseBean createPresentFromJson() =>
      GuessResponseBean.fromJson(presentJson());
}
