import '../entities/guess/guess.dart';

abstract class VoteeRepository {
  Future<List<GuessResponse>> guessRandom({
    required String guess,
    required int size,
    required int seed,
  });
}
