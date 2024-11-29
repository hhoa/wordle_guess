import 'dart:async';

import '../entities/guess/guess.dart';
import '../repositories/votee_repository.dart';

class GetGuessUsecase {
  GetGuessUsecase(this._voteeRepository);

  final VoteeRepository _voteeRepository;

  Future<List<GuessResponse>> run({
    required String guess,
    required int size,
    required int seed,
  }) async =>
      await _voteeRepository.guessRandom(guess: guess, size: size, seed: seed);
}
