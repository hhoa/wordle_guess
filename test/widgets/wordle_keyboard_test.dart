import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/model/box.dart';
import 'package:wordle_guess/src/widgets/wordle_keyboard.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render', (tester) async {
    final Box absentBox = Box(char: 'H', type: BoxType.notExist);
    final Box correctBox =
        Box(char: 'H', type: BoxType.existWithCorrectPosition);
    final Box presentBox =
        Box(char: 'H', type: BoxType.existWithIncorrectPosition);
    String pressedKey = '';
    final widget = createAppWidget(WordleKeyboard(
      keyboardMap: {
        'H': [absentBox],
        'O': [correctBox],
        'U': [presentBox]
      },
      onPressed: (char) {
        pressedKey = char;
      },
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsWidgets);

    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor == BoxType.notExist.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor ==
            BoxType.existWithCorrectPosition.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor ==
            BoxType.existWithIncorrectPosition.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);

    expect(pressedKey, '');
    await tester.tap(find.text('Q'));
    expect(pressedKey, 'Q');
  });
}
