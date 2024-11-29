import 'package:get/get_connect.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle_guess/src/data/api/bean/guess/request_bean.dart';
import 'package:wordle_guess/src/data/api/bean/guess/response_bean.dart';
import 'package:wordle_guess/src/data/api/provider/votee_provider.dart';
import 'package:wordle_guess/src/data/services/api/votee_service.dart';

class MockVoteeService extends Mock implements VoteeService {}

void main() {
  late MockVoteeService mockVoteeService;
  late VoteeProvider voteeProvider;

  setUp(() {
    mockVoteeService = MockVoteeService();
    voteeProvider = VoteeProvider.withMocks(mockVoteeService);
  });

  group('guessRandom', () {
    test('success', () async {
      const String guess = 'HOUSE';
      const int size = 5;
      const int seed = 1;
      when(() => mockVoteeService
          .callGet('/random?guess=$guess&size=$size&seed=$seed')).thenAnswer(
        (_) => Future<Response>.value(
          const Response(
            statusCode: 200,
            body: [
              {"slot": 0, "guess": "h", "result": "absent"},
              {"slot": 1, "guess": "o", "result": "absent"},
              {"slot": 2, "guess": "u", "result": "correct"},
              {"slot": 3, "guess": "s", "result": "absent"},
              {"slot": 4, "guess": "e", "result": "present"}
            ],
          ),
        ),
      );
      final List<GuessResponseBean> actual = await voteeProvider
          .guessRandom(GuessRequestBean(guess: guess, size: size, seed: seed));
      expect(actual[0].guess, 'h');
      expect(actual[0].slot, 0);
      expect(actual[0].result, 'absent');

      expect(actual[1].guess, 'o');
      expect(actual[1].slot, 1);
      expect(actual[1].result, 'absent');

      expect(actual[2].guess, 'u');
      expect(actual[2].slot, 2);
      expect(actual[2].result, 'correct');

      expect(actual[3].guess, 's');
      expect(actual[3].slot, 3);
      expect(actual[3].result, 'absent');

      expect(actual[4].guess, 'e');
      expect(actual[4].slot, 4);
      expect(actual[4].result, 'present');
    });
  });
}
