import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/box.dart';
import 'puzzle.dart';

class RowPuzzle extends GetView {
  const RowPuzzle({
    required this.boxes,
    super.key,
  });

  final List<Box> boxes;

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacer = 8;

    return Wrap(
      spacing: horizontalSpacer,
      alignment: WrapAlignment.center,
      children: boxes.map((box) => Puzzle(box: box)).toList(),
    );
  }
}
