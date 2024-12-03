import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/resources/typography.dart';

import '../../resources/colors.dart';
import '../../widgets/wordle_text.dart';
import 'controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle boldStyle = WordleTypographyTheme.textStyleBold;

    return Scaffold(
      backgroundColor: WordleColors.primaryColorMedium,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'W',
              style: boldStyle.copyWith(
                  fontSize: 120, color: WordleColors.lightPurple),
            ),
            const WordleTextWidget(),
          ],
        ),
      ),
    );
  }
}
