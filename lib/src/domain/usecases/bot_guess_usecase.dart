import 'dart:async';

import '../../model/box.dart';
import '../repositories/bot_repository.dart';

class BotGuessUsecase {
  BotGuessUsecase(this._botRepository);

  final BotRepository _botRepository;

  Future<String?> run(
    int numberOfBox, {
    required Map<String, Boxes> keyMap,
  }) async {
    final String? guess =
        await _botRepository.takeGuess(numberOfBox, keyMap: keyMap);
    return guess?.trim().toUpperCase();
  }
}
