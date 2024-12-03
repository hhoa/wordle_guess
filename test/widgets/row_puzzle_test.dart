import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/model/box.dart';
import 'package:wordle_guess/src/widgets/puzzle.dart';
import 'package:wordle_guess/src/widgets/row_puzzle.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render', (tester) async {
    final Box emptyBox = Box(char: null, type: BoxType.none);
    final Box absentBox = Box(char: 'H', type: BoxType.notExist);
    final Box correctBox =
        Box(char: 'H', type: BoxType.existWithCorrectPosition);
    final Box presentBox =
        Box(char: 'H', type: BoxType.existWithIncorrectPosition);
    final widget = createAppWidget(RowPuzzle(
      boxes: [
        absentBox,
        correctBox,
        presentBox,
        emptyBox,
        emptyBox,
      ],
      numberOfBox: 5,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsNWidgets(5));
    expect(find.byType(Puzzle), findsNWidgets(5));
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data == '';
      }
      return false;
    }), findsNWidgets(2));
    expect(find.byWidgetPredicate((widget) {
      if (widget is Container) {
        return (widget.decoration as BoxDecoration).color ==
            absentBox.type.boxBgColor;
      }
      return false;
    }), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Container) {
        return (widget.decoration as BoxDecoration).color ==
            correctBox.type.boxBgColor;
      }
      return false;
    }), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Container) {
        return (widget.decoration as BoxDecoration).color ==
            presentBox.type.boxBgColor;
      }
      return false;
    }), findsOneWidget);
  });
}
