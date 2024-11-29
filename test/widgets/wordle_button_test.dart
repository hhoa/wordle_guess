import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/widgets/wordle_button.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render text', (tester) async {
    bool isPressed = false;
    final widget = createAppWidget(WordleButton(
      title: WordleText.submit,
      onPressed: () {
        isPressed = true;
      },
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(isPressed, isFalse);

    await tester.tap(find.byType(WordleButton));
    await tester.pumpAndSettle();
    expect(isPressed, isTrue);
  });

  testWidgets('Can render widget', (tester) async {
    bool isPressed = false;
    final widget = createAppWidget(WordleButton(
      child: const CircularProgressIndicator(),
      onPressed: () {
        isPressed = true;
      },
    ));
    await tester.pumpWidget(widget);
    await tester.pump();

    expect(find.byType(Text), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(isPressed, isFalse);

    await tester.tap(find.byType(WordleButton));
    await tester.pump();
    expect(isPressed, isTrue);
  });
}
