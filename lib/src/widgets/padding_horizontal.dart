import 'package:flutter/material.dart';

import '../constant/constant.dart';

class HorizontalPadding extends StatelessWidget {
  const HorizontalPadding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: WordleConstant.horizontalPuzzlePadding / 2),
      child: child,
    );
  }
}
