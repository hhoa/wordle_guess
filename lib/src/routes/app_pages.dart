import 'package:get/get.dart';
import 'package:wordle_guess/src/pages/splash/controller.dart';
import 'package:wordle_guess/src/pages/splash/page.dart';

import '../data/repositories/gemini_repository_impl.dart';
import '../data/repositories/votee_repository_impl.dart';
import '../domain/usecases/bot_guess_usecase.dart';
import '../domain/usecases/get_guess_usecase.dart';
import '../pages/home/controller.dart';
import '../pages/home/page.dart';

part 'app_routes.dart';

abstract class AppPages {
  AppPages();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: Routes.splash,
      transition: Transition.fadeIn,
      page: () => const SplashPage(),
      bindings: <BindingsBuilder>[
        BindingsBuilder(
          () => Get.put<SplashController>(SplashController()),
        ),
      ],
    ),
    GetPage<dynamic>(
      name: Routes.home,
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      bindings: <BindingsBuilder>[
        BindingsBuilder(
          () => Get.put<GetGuessUsecase>(
              GetGuessUsecase(Get.find<VoteeRepositoryImpl>())),
        ),
        BindingsBuilder(
          () => Get.put<BotGuessUsecase>(
              BotGuessUsecase(Get.find<GeminiRepositoryImpl>())),
        ),
        BindingsBuilder(
          () => Get.put<HomeController>(HomeController(
            Get.find<GetGuessUsecase>(),
            Get.find<BotGuessUsecase>(),
          )),
        ),
      ],
    ),
  ];
}
