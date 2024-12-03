import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/enum/level.dart';
import 'package:wordle_guess/src/enum/widget_keys.dart';
import 'package:wordle_guess/src/pages/home/page.dart';
import 'package:wordle_guess/src/pages/splash/controller.dart';
import 'package:wordle_guess/src/pages/splash/page.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/widgets/puzzle.dart';
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
    
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text && widget.key == Key(WidgetKeys.levelText.name)) {
        return widget.data == '1';
      }
      return false;
    }), findsOneWidget);

    // press keyboard word: FEAST
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-F')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-E')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-A')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-S')));
    await tester.tap(find.byKey(Key('${WidgetKeys.keyboardButton.name}-T')));
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

    // F, A: not exist. S, T: correct, E: present
    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-F')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor == BoxType.notExist.keyboardBgColor;
      }
      return false;
    }), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton &&
          widget.key == Key('${WidgetKeys.keyboardButton.name}-A')) {
        final backgroundColor =
            widget.style?.backgroundColor?.resolve(<WidgetState>{});
        return backgroundColor == BoxType.notExist.keyboardBgColor;
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
          widget.key == Key('${WidgetKeys.keyboardButton.name}-T')) {
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

    // bot guess: GUEST which is correct word
    await tester.tap(find.byKey(Key(WidgetKeys.botGuessButton.name)));
    await tester.pumpAndSettle();

    expect(find.text(WordleText.congrats), findsOneWidget);
    await tester.tap(find.text(WordleText.next));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) {
      if (widget is Text && widget.key == Key(WidgetKeys.levelText.name)) {
        return widget.data == '2';
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('Open settings', (WidgetTester tester) async {
    await tester.pumpWidget(mockApp);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(Puzzle), findsNWidgets(Level.medium.numberOfBox));

    await tester.tap(find.byKey(Key(WidgetKeys.settingButton.name)));
    await tester.pumpAndSettle();

    await tester.tap(find.text(Level.easy.text));
    await tester.pumpAndSettle();

    expect(find.byType(Puzzle), findsNWidgets(Level.easy.numberOfBox));
  });
}
