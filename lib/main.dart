import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wordle_guess/src/data/services/bot/gemini_service.dart';

import 'src/data/repositories/gemini_repository_impl.dart';
import 'src/data/repositories/votee_repository_impl.dart';
import 'src/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: Routes.splash,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<VoteeRepositoryImpl>(() => VoteeRepositoryImpl(),
            fenix: true);
        Get.lazyPut<GeminiService>(() => GeminiService(), fenix: true);
        Get.lazyPut<GeminiRepositoryImpl>(() => GeminiRepositoryImpl(),
            fenix: true);
      }),
    );
  }
}
