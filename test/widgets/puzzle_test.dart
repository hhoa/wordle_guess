import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/model/box.dart';
import 'package:wordle_guess/src/widgets/puzzle.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render empty', (tester) async {
    final Box emptyBox = Box(char: null, type: BoxType.none);
    final widget = createAppWidget(Puzzle(box: emptyBox));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data == '';
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('Can render absent', (tester) async {
    final Box absentBox = Box(char: 'H', type: BoxType.notExist);
    final widget = createAppWidget(Puzzle(box: absentBox));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Container) {
        return (widget.decoration as BoxDecoration).color ==
            absentBox.type.boxBgColor;
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('Can render correct', (tester) async {
    final Box correctBox =
        Box(char: 'H', type: BoxType.existWithCorrectPosition);
    final widget = createAppWidget(Puzzle(box: correctBox));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Container) {
        return (widget.decoration as BoxDecoration).color ==
            correctBox.type.boxBgColor;
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('Can render present', (tester) async {
    final Box presentBox =
        Box(char: 'H', type: BoxType.existWithIncorrectPosition);
    final widget = createAppWidget(Puzzle(box: presentBox));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Container) {
        return (widget.decoration as BoxDecoration).color ==
            presentBox.type.boxBgColor;
      }
      return false;
    }), findsOneWidget);
  });
}
