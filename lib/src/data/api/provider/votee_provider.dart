import 'package:get/get_connect.dart';

import '../bean/guess/request_bean.dart';
import '../bean/guess/response_bean.dart';
import '../service/api_service.dart';

class VoteeProvider {
  VoteeProvider() : _voteeService = VoteeService();

  VoteeProvider.withMocks(this._voteeService);

  final VoteeService _voteeService;

  Future<List<GuessResponseBean>> guessRandom(GuessRequestBean bean) async {
    try {
      final Response response = await _voteeService.callGet(
          '/random?guess=${bean.guess}&size=${bean.size}&seed=${bean.seed}');

      final List<dynamic> parsedJson = response.body;
      return List<GuessResponseBean>.from(
        parsedJson.map((dynamic data) {
          return GuessResponseBean.fromJson(data as Map<String, dynamic>);
        }),
      );
    } on Exception {
      rethrow;
    }
  }
}
