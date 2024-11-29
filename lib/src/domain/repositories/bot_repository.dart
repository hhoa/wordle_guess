import '../../model/box.dart';

abstract class BotRepository {
  Future<String?> takeGuess({
    required Map<String, Boxes> keyMap,
  });
}
