class GuessRequestBean {
  GuessRequestBean({
    required this.guess,
    required this.size,
    required this.seed,
  });

  final String guess;
  final int size;
  final int seed;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'guess': guess,
        'size': size,
        'seed': seed,
      };

  factory GuessRequestBean.fromJson(Map<String, dynamic> json) {
    return GuessRequestBean(
      guess: json['guess'] as String,
      size: json['size'] as int,
      seed: json['seed'] as int,
    );
  }
}
