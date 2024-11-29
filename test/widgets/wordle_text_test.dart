import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/constant/constant.dart';
import 'package:wordle_guess/src/widgets/wordle_text.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render', (tester) async {
    final widget = createAppWidget(const WordleTextWidget());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsNWidgets(WordleConstant.splashChars.length));
    expect(find.byType(Container),
        findsNWidgets(WordleConstant.splashChars.length));
  });
}
