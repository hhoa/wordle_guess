import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_guess/src/widgets/circular_loading.dart';

import '../mock_app.dart';

void main() {
  testWidgets('Can render', (tester) async {
    final widget = createAppWidget(const WordleCircularLoading());
    await tester.pumpWidget(widget);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
