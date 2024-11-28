import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/colors.dart';
import 'controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WordleColors.bgColor,
      body: const Center(child: Text('W')),
    );
  }
}
