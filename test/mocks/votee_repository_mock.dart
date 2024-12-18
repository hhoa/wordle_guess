import 'package:mocktail/mocktail.dart';
import 'package:wordle_guess/src/data/repositories/votee_repository_impl.dart';
import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/enum/box.dart';

class MockVoteeRepository extends Mock implements VoteeRepositoryImpl {
  @override
  Future<List<GuessResponse>> guessRandom({
    required String guess,
    required int size,
    required int seed,
  }) {
    if (guess.toUpperCase() == 'FEAST') {
      return Future<List<GuessResponse>>.value([
        GuessResponse(slot: 0, guess: 'f', type: BoxType.notExist),
        GuessResponse(
            slot: 1, guess: 'e', type: BoxType.existWithIncorrectPosition),
        GuessResponse(slot: 2, guess: 'a', type: BoxType.notExist),
        GuessResponse(
            slot: 3, guess: 's', type: BoxType.existWithCorrectPosition),
        GuessResponse(
            slot: 4, guess: 't', type: BoxType.existWithCorrectPosition),
      ]);
    } else {
      return Future<List<GuessResponse>>.value([
        GuessResponse(
            slot: 0, guess: 'g', type: BoxType.existWithCorrectPosition),
        GuessResponse(
            slot: 1, guess: 'u', type: BoxType.existWithCorrectPosition),
        GuessResponse(
            slot: 2, guess: 'e', type: BoxType.existWithCorrectPosition),
        GuessResponse(
            slot: 3, guess: 's', type: BoxType.existWithCorrectPosition),
        GuessResponse(
            slot: 4, guess: 't', type: BoxType.existWithCorrectPosition),
      ]);
    }
  }
}
