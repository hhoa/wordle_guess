import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/box.dart';

import '../../domain/repositories/bot_repository.dart';
import '../../model/box.dart';
import '../services/bot/gemini_service.dart';

class GeminiRepositoryImpl implements BotRepository {
  GeminiRepositoryImpl() : geminiService = Get.find();

  GeminiRepositoryImpl.withMocks({
    required this.geminiService,
  });

  final GeminiService geminiService;

  @override
  Future<String?> takeGuess(
    int numberOfBox, {
    required Map<String, Boxes> keyMap,
  }) async {
    final Boxes correct = [];
    final List<String> present = [];
    final List<String> absent = [];

    keyMap.forEach((key, boxes) {
      if (boxes.isNotEmpty) {
        final Box firstBox = boxes.first;
        final BoxType type = firstBox.type;
        switch (type) {
          case BoxType.none:
            break;
          case BoxType.notExist:
            absent.add(firstBox.char!);
            break;
          case BoxType.existWithIncorrectPosition:
            present.add(firstBox.char!);
            break;
          case BoxType.existWithCorrectPosition:
            correct.addAll(boxes);
            break;
        }
      }
    });

    return geminiService.takeGuess(
      numberOfBox,
      correct: correct,
      present: present,
      absent: absent,
    );
  }
}
