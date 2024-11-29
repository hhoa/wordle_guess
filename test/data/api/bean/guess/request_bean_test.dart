import 'package:test/test.dart';
import 'package:wordle_guess/src/data/api/bean/guess/request_bean.dart';

void main() {
  test('can create from json', () {
    final GuessRequestBean bean = GuessRequestBeanSample.createFromJson();
    expect(bean.guess, 'HOUSE');
    expect(bean.size, 5);
    expect(bean.seed, 1);
  });
}

class GuessRequestBeanSample {
  GuessRequestBeanSample();

  static Map<String, dynamic> defaultJson() => <String, dynamic>{
        'guess': 'HOUSE',
        'size': 5,
        'seed': 1,
      };

  static GuessRequestBean createFromJson() =>
      GuessRequestBean.fromJson(defaultJson());
}
