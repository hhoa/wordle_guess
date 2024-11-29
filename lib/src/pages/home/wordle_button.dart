import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/colors.dart';
import '../../resources/typography.dart';

class WordleButton extends GetView {
  const WordleButton({
    this.title,
    this.child,
    this.bgColor,
    this.onPressed,
    super.key,
  }) : assert(
          (title != null && child == null) || (title == null && child != null),
          'Either "title" or "child" must be provided, but not both.',
        );

  final String? title;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? WordleColors.lightGreen,
      ),
      child: child ??
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title ?? '',
              style: WordleTypographyTheme.textStyleBold.copyWith(
                fontSize: 18,
              ),
            ),
          ),
    );
  }
}
