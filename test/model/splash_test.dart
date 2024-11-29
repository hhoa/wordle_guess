import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:wordle_guess/src/model/splash.dart';

void main() {
  test('can set', () {
    final SplashChar model = SplashSample.create();

    expect(model.char, 'h');
    expect(model.color, Colors.white);
  });
}

class SplashSample {
  SplashSample();

  static SplashChar create() => SplashChar(
        char: 'h',
        color: Colors.white,
      );
}
