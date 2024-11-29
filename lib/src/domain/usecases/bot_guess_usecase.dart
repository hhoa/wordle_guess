import 'dart:async';

import '../../model/box.dart';
import '../repositories/bot_repository.dart';

class BotGuessUsecase {
  BotGuessUsecase(this._botRepository);

  final BotRepository _botRepository;

  Future<String?> takeGuess({
    required Map<String, Boxes> keyMap,
  }) {
    return _botRepository.takeGuess(keyMap: keyMap);
  }
}
