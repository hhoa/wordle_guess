import 'package:flutter/material.dart';
import 'package:wordle_guess/src/resources/colors.dart';

class WordleCircularLoading extends StatelessWidget {
  const WordleCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: WordleColors.primaryColor,
    );
  }
}
