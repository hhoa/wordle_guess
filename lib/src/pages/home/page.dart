import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_guess/src/enum/level.dart';

import '../../constant/constant.dart';
import '../../enum/button.dart';
import '../../enum/widget_keys.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import '../../resources/typography.dart';
import '../../utils/dialog.dart';
import '../../widgets/padding_horizontal.dart';
import 'controller.dart';
import '../../widgets/row_puzzle.dart';
import '../../widgets/wordle_keyboard.dart';
import '../../widgets/wordle_button.dart';
import 'widgets/submit_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AnimatedContainer(
          duration: WordleConstant.animationDuration,
          color: controller.level.bgColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSpacing(),
                _buildHeader(),
                _buildSpacing(),
                _buildPuzzle(),
                _buildSpacing(),
                _buildKeyboard(),
                _buildSpacing(),
                _buildButtons(),
                _buildSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpacing() => const SizedBox(height: 20);

  Widget _buildHeader() {
    return WordleHorizontalPadding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => WordleDialog.showTutorial(
                controller.level, controller.numberOfBox),
            borderRadius: BorderRadius.circular(60),
            child: Icon(
              Icons.info_outline,
              color: WordleColors.lightPurple,
              size: 30,
            ),
          ),
          Column(
            children: [
              Text(
                WordleText.level,
                style: WordleTypographyTheme.textStyleLight
                    .copyWith(color: WordleColors.lightPurple),
              ),
              Obx(
                () => Text(
                  key: Key(WidgetKeys.levelText.name),
                  '${controller.stage}',
                  style: WordleTypographyTheme.textStyleBold.copyWith(
                    fontSize: 20,
                    color: WordleColors.lightPurple,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            key: Key(WidgetKeys.settingButton.name),
            onTap: () => WordleDialog.showSettings(controller.level,
                onTap: controller.updateLevel),
            borderRadius: BorderRadius.circular(60),
            child: Icon(
              Icons.settings,
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
        () => AnimatedList.separated(
          key: controller.listPuzzleKey,
          controller: controller.scrollController,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, int index, animation) {
            return SlideTransition(
              position: animation.drive(Tween<Offset>(
                begin: const Offset(0, -1), // Slide in from the left
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeIn))),
              child: RowPuzzle(
                boxes: controller.listBoxes[index],
                numberOfBox: controller.numberOfBox,
              ),
            );
          },
          separatorBuilder: (_, __, ___) => const SizedBox(height: 8),
          initialItemCount: controller.puzzleCount,
          removedSeparatorBuilder: (_, __, ___) => const SizedBox(height: 8),
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
    return WordleHorizontalPadding(
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
        key: Key(WidgetKeys.botGuessButton.name),
        onPressed: controller.submitButtonType == ButtonType.loading
            ? null
            : controller.onBotGuess,
        bgColor: controller.level.botGuessButtonColor,
        child: Icon(
          Icons.fast_forward_rounded,
          color: WordleColors.white,
          size: 30,
        ),
      ),
    );
  }
}
