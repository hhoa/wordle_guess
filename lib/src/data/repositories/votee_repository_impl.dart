import 'package:wordle_guess/src/data/api/bean/guess/request_bean.dart';
import 'package:wordle_guess/src/data/api/bean/guess/response_bean.dart';

import '../../domain/entities/guess/guess.dart';
import '../../domain/repositories/votee_repository.dart';
import '../api/provider/votee_provider.dart';

class VoteeRepositoryImpl implements VoteeRepository {
  VoteeRepositoryImpl() : voteeProvider = VoteeProvider();

  VoteeRepositoryImpl.withMocks({
    required this.voteeProvider,
  });

  final VoteeProvider voteeProvider;

  @override
  Future<List<GuessResponse>> guessRandom({
    required String guess,
    required int size,
    required int seed,
  }) async {
    final GuessRequestBean requestBean =
        GuessRequestBean(guess: guess, size: size, seed: seed);
    final List<GuessResponseBean> responseBean =
        await voteeProvider.guessRandom(requestBean);
    return responseBean.map((bean) => bean.toEntity()).toList();
  }
}
