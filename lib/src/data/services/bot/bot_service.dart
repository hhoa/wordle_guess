import 'package:get/get.dart';

import '../../../model/box.dart';

abstract class BotService extends GetxService {
  Future<String?> takeGuess({
    required Boxes correct,
    required List<String> present,
    required List<String> absent,
  });
}
