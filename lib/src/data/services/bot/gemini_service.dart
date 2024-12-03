import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:wordle_guess/src/constant/constant.dart';
import 'package:wordle_guess/src/extension/int.dart';
import 'package:wordle_guess/src/model/box.dart';

import 'bot_service.dart';

class GeminiService extends BotService {
  late final GenerativeModel genModel;

  @override
  void onInit() {
    super.onInit();

    const String apiKey = String.fromEnvironment('gemini_key');
    genModel = GenerativeModel(
      model: WordleConstant.geminiModel,
      apiKey: apiKey,
    );
  }

  @override
  Future<String?> takeGuess(int numberOfBox,
      {required Boxes correct,
      required List<String> present,
      required List<String> absent}) async {
    final String suggestPrompt = 'Suggest a $numberOfBox-letter word';
    String conditionPrompt = '';
    if (correct.isNotEmpty || present.isNotEmpty || absent.isNotEmpty) {
      conditionPrompt += ' where: ';
      if (correct.isNotEmpty) {
        conditionPrompt += correct
            .map<String>((box) {
              final int? slot = box.slot;
              final String? char = box.char;
              if (slot == null || char == null) {
                return '';
              }

              return '$char is the ${(slot + 1).toOrdinalNumber} letter';
            })
            .toList()
            .join(', ');
        conditionPrompt += '. ';
      }

      if (present.isNotEmpty) {
        conditionPrompt += '${present.join(', ')} are in word. ';
      }

      if (absent.isNotEmpty) {
        conditionPrompt += '${absent.join(', ')} are NOT in word. ';
      }
    } else {
      conditionPrompt += '. ';
    }

    const String wordOnlyPrompt =
        'Return the word only. No need explanation or anything else';
    final String prompt = suggestPrompt + conditionPrompt + wordOnlyPrompt;

    final GenerateContentResponse response = await genModel.generateContent(
        [Content.text(prompt)],
        generationConfig: GenerationConfig(temperature: 1));
    return response.text;
  }
}
