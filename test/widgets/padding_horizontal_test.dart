import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/widgets/padding_horizontal.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render', (tester) async {
    final widget = createAppWidget(WordleHorizontalPadding(child: Container()));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(Padding), findsOneWidget);
  });
}
