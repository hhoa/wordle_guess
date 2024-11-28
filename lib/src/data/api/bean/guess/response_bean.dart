import 'package:wordle_guess/src/domain/entities/guess/guess.dart';
import 'package:wordle_guess/src/enum/box.dart';

class GuessResponseBean {
  GuessResponseBean({
    required this.slot,
    required this.guess,
    required this.result,
  });

  final int slot;
  final String guess;
  final String result;

  factory GuessResponseBean.fromJson(Map<String, dynamic> json) =>
      GuessResponseBean(
        slot: json['slot'],
        guess: json['guess'],
        result: json['result'],
      );

  Map<String, dynamic> toJson() => {
        'slot': slot,
        'guess': guess,
        'result': result,
      };

  GuessResponse toEntity() {
    final BoxType type = BoxType.values.singleWhere(
        (type) => type.param == result,
        orElse: () => BoxType.none);

    return GuessResponse(guess: guess, slot: slot, type: type);
  }
}
