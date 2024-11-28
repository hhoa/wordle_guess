import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/button.dart';
import 'package:wordle_guess/src/pages/home/controller.dart';

import '../../../resources/colors.dart';
import '../../../resources/strings.dart';
import '../../../resources/typography.dart';
import '../../../widgets/circular_loading.dart';

class SubmitButton extends GetView<HomeController> {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ElevatedButton(
          onPressed: controller.submitButtonType == ButtonType.enabled
              ? controller.onSubmitted
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: WordleColors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: controller.submitButtonType == ButtonType.loading
                ? const WordleCircularLoading()
                : Text(
                    WordleText.submit,
                    style: WordleTypographyTheme.textStyleBold
                        .copyWith(fontSize: 18),
                  ),
          ),
        );
      },
    );
  }
}
