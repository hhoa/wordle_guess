import 'package:test/test.dart';
import 'package:wordle_guess/src/constant/service_path.dart';
import 'package:wordle_guess/src/data/services/api/votee_service.dart';

void main() {
  group('VoteeService', () {
    final VoteeService voteeService = VoteeService();
    test('instance has correct path', () {
      expect(voteeService.servicePath, WordleServicePath.voteeServicePath);
    });
  });
}
