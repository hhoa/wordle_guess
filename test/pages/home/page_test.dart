import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/enum/widget_keys.dart';
import 'package:wordle_guess/src/pages/home/page.dart';
import 'package:wordle_guess/src/pages/splash/controller.dart';
import 'package:wordle_guess/src/pages/splash/page.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/widgets/row_puzzle.dart';
import 'package:wordle_guess/src/widgets/wordle_button.dart';
import 'package:wordle_guess/src/widgets/wordle_keyboard.dart';
import 'package:wordle_guess/src/widgets/wordle_text.dart';

import '../../mock_app.dart';

void main() {
  late MockApp mockApp;

  setUp(() async {
    mockApp = await MockAppUtil.createMockApp(
      child: const SplashPage(),
      bindings: () {
        Get.put<SplashController>(SplashController());
      },
    );
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Can render', (WidgetTester tester) async {
    await tester.pumpWidget(mockApp);
    await tester.pumpAndSettle();

    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.byType(WordleTextWidget), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(HomePage), findsOneWidget);

    // display tutorial
    expect(find.text(WordleText.howToPlay), findsOneWidget);
    await tester.tap(find.text(WordleText.howToPlay));
    await tester.pumpAndSettle();

    expect(find.byType(RowPuzzle), findsOneWidget);
    expect(find.byType(WordleKeyboard), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is WordleButton &&
          widget.key == Key(WidgetKeys.submitButton.name)) {
        return widget.onPressed == null;
      }
      return false;
    }), findsOneWidget);

    // press keyboard word: HOUSE
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-H')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-O')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-U')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-S')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-E')));
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget) {
      if (widget is WordleButton &&
          widget.key == Key(WidgetKeys.submitButton.name)) {
        return widget.onPressed == null;
      }
      return false;
    }), findsNothing);

    await tester.tap(find.byKey(Key(WidgetKeys.submitButton.name)));
    await tester.pumpAndSettle();

    // H, O: not exist. U, S: correct, E: present
    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-H')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor == BoxType.notExist.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-O')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor == BoxType.notExist.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-U')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor ==
            BoxType.existWithCorrectPosition.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-S')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor ==
            BoxType.existWithCorrectPosition.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-E')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor ==
            BoxType.existWithIncorrectPosition.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);
  });
}
