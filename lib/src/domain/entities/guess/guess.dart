import '../../../enum/box.dart';

class GuessResponse {
  GuessResponse({
    required this.slot,
    required this.guess,
    required this.type,
  });

  final int slot;
  final String guess;
  final BoxType type;
}
