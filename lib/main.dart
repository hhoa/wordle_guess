import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'src/data/provider/api_provider.dart';
// import 'src/repositories/person.dart';
import 'src/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: Routes.splash,
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut<ApiProvider>(() => ApiProvider(), fenix: true);
      //   Get.lazyPut<PersonRepository>(() => PersonRepository(Get.find()),
      //       fenix: true);
      // }),
    );
  }
}
