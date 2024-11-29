import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/domain/repositories/votee_repository.dart';
import 'package:wordle_guess/src/domain/usecases/get_guess_usecase.dart';
import 'package:wordle_guess/src/enum/box.dart';

class MockVoteeRepository extends Mock implements VoteeRepository {}

void main() {
  late VoteeRepository voteeRepository;

  setUp(() {
    voteeRepository = MockVoteeRepository();
  });

  group('GetGuessUsecase', () {
    test('run', () async {
      const String guess = 'HOUSE';
      const int size = 5;
      const int seed = 1;
      when(() =>
              voteeRepository.guessRandom(guess: guess, seed: seed, size: size))
          .thenAnswer((_) => Future<List<GuessResponse>>.value(<GuessResponse>[
                GuessResponse(
                  guess: 'h',
                  slot: 0,
                  type: BoxType.notExist,
                ),
                GuessResponse(
                  guess: 'o',
                  slot: 1,
                  type: BoxType.notExist,
                ),
                GuessResponse(
                  guess: 'u',
                  slot: 2,
                  type: BoxType.existWithCorrectPosition,
                ),
                GuessResponse(
                  guess: 's',
                  slot: 3,
                  type: BoxType.notExist,
                ),
                GuessResponse(
                  guess: 'e',
                  slot: 4,
                  type: BoxType.existWithIncorrectPosition,
                ),
              ]));
      final GetGuessUsecase uc = GetGuessUsecase(voteeRepository);
      final List<GuessResponse> actual =
          await uc.run(guess: guess, seed: seed, size: size);
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
}
