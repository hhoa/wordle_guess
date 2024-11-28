import 'package:get/get.dart';
import 'package:wordle_guess/src/pages/splash/controller.dart';
import 'package:wordle_guess/src/pages/splash/page.dart';

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
          () => Get.put<HomeController>(HomeController()),
        ),
      ],
    ),
  ];
}
