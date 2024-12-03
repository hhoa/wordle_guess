import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/level.dart';

import '../../../enum/button.dart';
import '../../../enum/widget_keys.dart';
import '../../../resources/strings.dart';
import '../../../widgets/circular_loading.dart';
import '../controller.dart';
import '../../../widgets/wordle_button.dart';

class SubmitButton extends GetView<HomeController> {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isLoading = controller.submitButtonType == ButtonType.loading;

      return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 156,
          minHeight: 58,
        ),
        child: WordleButton(
          key: Key(WidgetKeys.submitButton.name),
          title: isLoading ? null : WordleText.submit,
          onPressed: controller.submitButtonType == ButtonType.enabled
              ? controller.onSubmitted
              : null,
          bgColor: controller.level.submitButtonColor,
          child: isLoading ? const WordleCircularLoading() : null,
        ),
      );
    });
  }
}
