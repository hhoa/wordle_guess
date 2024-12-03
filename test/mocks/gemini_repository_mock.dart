import 'package:mocktail/mocktail.dart';
import 'package:wordle_guess/src/data/repositories/gemini_repository_impl.dart';
import 'package:wordle_guess/src/model/box.dart';

class MockGeminiRepository extends Mock implements GeminiRepositoryImpl {
  @override
  Future<String?> takeGuess(
    int numberOfBox, {
    required Map<String, Boxes> keyMap,
  }) =>
      Future<String?>.value('guest\n');
}
