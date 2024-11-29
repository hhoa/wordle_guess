import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/data/repositories/gemini_repository_impl.dart';
import 'package:wordle_guess/src/data/repositories/votee_repository_impl.dart';
import 'package:wordle_guess/src/routes/app_pages.dart';

import 'mocks/gemini_repository_mock.dart';
import 'mocks/votee_repository_mock.dart';

class MockAppUtil {
  MockAppUtil();

  static Future<MockApp> createMockApp({
    Key? key,
    VoidCallback? bindings,
    required Widget child,
    String? route,
  }) async {
    return MockApp(
      key: key,
      bindings: bindings,
      route: route,
      child: child,
    );
  }
}

class MockApp extends StatelessWidget {
  MockApp({super.key, required this.child, this.bindings, this.route}) {
    Get.testMode = true;
  }

  final Widget child;
  final VoidCallback? bindings;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: route ?? Routes.splash,
      initialBinding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<VoteeRepositoryImpl>(() => MockVoteeRepository(),
            fenix: true);
        Get.lazyPut<GeminiRepositoryImpl>(() => MockGeminiRepository(),
            fenix: true);
        if (bindings != null) {
          bindings!();
        }
      }),
      home: child,
    );
  }
}

Widget createAppWidget(Widget child) =>
    GetMaterialApp(locale: const Locale('en'), home: child);
