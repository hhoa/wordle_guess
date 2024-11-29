import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle_guess/src/domain/repositories/bot_repository.dart';
import 'package:wordle_guess/src/domain/usecases/bot_guess_usecase.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/model/box.dart';

class MockBotRepository extends Mock implements BotRepository {}

void main() {
  late BotRepository botRepository;

  setUp(() {
    botRepository = MockBotRepository();
  });

  group('BotGuessUsecase', () {
    test('run', () async {
      const String guess = 'HOUSE';
      final Map<String, Boxes> keyMap = {
        'h': [Box(char: 'h', slot: 0, type: BoxType.notExist)]
      };
      when(() => botRepository.takeGuess(keyMap: keyMap))
          .thenAnswer((_) => Future<String?>.value(guess));
      final BotGuessUsecase uc = BotGuessUsecase(botRepository);
      final String? actual = await uc.run(keyMap: keyMap);
      expect(actual?.length, 5);
      expect(actual, guess);
    });
  });
}
