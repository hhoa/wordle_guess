import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/pages/home/widgets/submit_button.dart';
import 'package:wordle_guess/src/utils/dialog.dart';

import '../../enum/button.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import '../../resources/typography.dart';
import '../../widgets/padding_horizontal.dart';
import 'controller.dart';
import '../../widgets/row_puzzle.dart';
import '../../widgets/wordle_keyboard.dart';
import 'wordle_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WordleColors.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildSpacing(),
            _buildPuzzle(),
            _buildSpacing(),
            _buildKeyboard(),
            _buildSpacing(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacing() => const SizedBox(height: 20);

  Widget _buildHeader() {
    return HorizontalPadding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 30),
          Column(
            children: [
              Text(
                WordleText.level,
                style: WordleTypographyTheme.textStyleLight
                    .copyWith(color: WordleColors.lightPurple),
              ),
              Obx(
                () => Text(
                  '${controller.level}',
                  style: WordleTypographyTheme.textStyleBold.copyWith(
                    fontSize: 20,
                    color: WordleColors.lightPurple,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: WordleDialog.showTutorial,
            borderRadius: BorderRadius.circular(60),
            child: Icon(
              Icons.info_outline,
              color: WordleColors.lightPurple,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzle() {
    return Expanded(
      child: Obx(
        () => ListView.separated(
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, int index) {
            return RowPuzzle(
              boxes: controller.listBoxes[index],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: controller.puzzleCount,
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Obx(
      () => WordleKeyboard(
        key: ValueKey(controller.keyboardMap.keys.length),
        keyboardMap: controller.keyboardMap,
        onPressed: controller.submitButtonType == ButtonType.loading
            ? null
            : controller.inputKey,
      ),
    );
  }

  Widget _buildButtons() {
    return HorizontalPadding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 56),
          const SubmitButton(),
          _buildBotGuessButton(),
        ],
      ),
    );
  }

  Widget _buildBotGuessButton() {
    return Obx(
      () => WordleButton(
        onPressed: controller.submitButtonType == ButtonType.loading
            ? null
            : controller.onBotGuess,
        child: Icon(
          Icons.fast_forward_rounded,
          color: WordleColors.white,
          size: 30,
        ),
      ),
    );
  }
}
