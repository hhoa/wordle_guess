import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle_guess/src/data/api/bean/guess/request_bean.dart';
import 'package:wordle_guess/src/data/api/bean/guess/response_bean.dart';
import 'package:wordle_guess/src/data/api/provider/votee_provider.dart';
import 'package:wordle_guess/src/data/repositories/votee_repository_impl.dart';
import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/domain/repositories/votee_repository.dart';
import 'package:wordle_guess/src/enum/box.dart';

import '../api/bean/guess/request_bean_test.dart';

class MockVoteeProvider extends Mock implements VoteeProvider {}

class FakeGuessRequestBean extends Fake implements GuessRequestBean {}

void main() {
  late MockVoteeProvider voteeProvider;
  late VoteeRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeGuessRequestBean());
  });

  setUp(() {
    voteeProvider = MockVoteeProvider();
    repository = VoteeRepositoryImpl.withMocks(voteeProvider: voteeProvider);
  });

  group('VoteeRepositoryImpl', () {
    group('guessRandom', () {
      test('success', () async {
        final GuessRequestBean requestBean =
            GuessRequestBeanSample.createFromJson();

        when(
          () => voteeProvider.guessRandom(any()),
        ).thenAnswer(
            (_) => Future<List<GuessResponseBean>>.value(<GuessResponseBean>[
                  GuessResponseBean(
                    guess: 'h',
                    slot: 0,
                    result: BoxType.notExist.param,
                  ),
                  GuessResponseBean(
                    guess: 'o',
                    slot: 1,
                    result: BoxType.notExist.param,
                  ),
                  GuessResponseBean(
                    guess: 'u',
                    slot: 2,
                    result: BoxType.existWithCorrectPosition.param,
                  ),
                  GuessResponseBean(
                    guess: 's',
                    slot: 3,
                    result: BoxType.notExist.param,
                  ),
                  GuessResponseBean(
                    guess: 'e',
                    slot: 4,
                    result: BoxType.existWithIncorrectPosition.param,
                  ),
                ]));
        final List<GuessResponse> actual = await repository.guessRandom(
          guess: requestBean.guess,
          size: requestBean.size,
          seed: requestBean.seed,
        );
        expect(actual.length, 5);
        expect(actual[0].guess, 'h');
        expect(actual[0].slot, 0);
        expect(actual[0].type, BoxType.notExist);

        expect(actual[1].guess, 'o');
        expect(actual[1].slot, 1);
        expect(actual[1].type, BoxType.notExist);

        expect(actual[2].guess, 'u');
        expect(actual[2].slot, 2);
        expect(actual[2].type, BoxType.existWithCorrectPosition);

        expect(actual[3].guess, 's');
        expect(actual[3].slot, 3);
        expect(actual[3].type, BoxType.notExist);

        expect(actual[4].guess, 'e');
        expect(actual[4].slot, 4);
        expect(actual[4].type, BoxType.existWithIncorrectPosition);
      });
    });
  });
}
