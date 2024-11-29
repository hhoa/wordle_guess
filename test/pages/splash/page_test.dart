import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/pages/home/page.dart';
import 'package:wordle_guess/src/pages/splash/controller.dart';
import 'package:wordle_guess/src/pages/splash/page.dart';
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
  });
}
