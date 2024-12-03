import '../../model/box.dart';

abstract class BotRepository {
  Future<String?> takeGuess(
    int numberOfBox, {
    required Map<String, Boxes> keyMap,
  });
}
