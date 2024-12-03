import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wordle_guess/src/constant/preference_keys.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/resources/colors.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/widgets/puzzle.dart';
import 'package:wordle_guess/src/widgets/row_puzzle.dart';
import 'package:wordle_guess/src/widgets/wordle_text.dart';

import '../constant/constant.dart';
import '../enum/level.dart';
import '../model/box.dart';
import '../widgets/wordle_button.dart';
import '../resources/typography.dart';
import '../widgets/padding_horizontal.dart';

class WordleDialog {
  static void showError(String error) {
    Get.defaultDialog(
      title: WordleText.somethingWentWrong,
      titleStyle: WordleTypographyTheme.textStyleBold.copyWith(
        fontSize: 20,
        color: WordleColors.lightPurple,
      ),
      titlePadding: const EdgeInsets.only(top: 20),
      content: Text(
        '$error\n${WordleText.tryAgainLater}',
        style: WordleTypographyTheme.textStyleMedium.copyWith(
          fontSize: 18,
          color: WordleColors.grey,
        ),
        textAlign: TextAlign.center,
      ),
      confirm: WordleButton(
        title: WordleText.okay,
        onPressed: Get.back,
      ),
    );
  }

  static void showSuccessDialog(
    Level currentLevel, {
    required Boxes correctWord,
    required VoidCallback onNext,
    required int numberOfBox,
  }) {
    Get.generalDialog(
      pageBuilder: (context, _, __) {
        return Material(
          color: currentLevel.dialogBgColor.withOpacity(0.6),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const WordleTextWidget(size: 20),
                const SizedBox(height: 20),
                Text(
                  WordleText.congrats,
                  style: WordleTypographyTheme.textStyleBold
                      .copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  WordleText.clearedLevel,
                  style: WordleTypographyTheme.textStyleBold
                      .copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                RowPuzzle(boxes: correctWord, numberOfBox: numberOfBox),
                const SizedBox(height: 20),
                const Spacer(),
                WordleHorizontalPadding(
                  child: WordleButton(
                    title: WordleText.next,
                    onPressed: onNext,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSettings(
    Level currentLevel, {
    required Function(Level) onTap,
  }) {
    Widget buildLevelButton(Level lvl) {
      final bool isSelected = lvl == currentLevel;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: WordleButton(
          title: lvl.text,
          bgColor: isSelected
              ? WordleColors.lightGreen
              : WordleColors.lightGreen.withOpacity(0.5),
          onPressed: () {
            if (!isSelected) {
              onTap(lvl);
            }
            Get.back();
          },
        ),
      );
    }

    Get.generalDialog(
      pageBuilder: (context, _, __) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Material(
            color: currentLevel.dialogBgColor.withOpacity(0.6),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WordleTextWidget(size: 20),
                  const SizedBox(height: 20),
                  Text(
                    WordleText.settings,
                    style: WordleTypographyTheme.textStyleBold
                        .copyWith(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  buildLevelButton(Level.easy),
                  const SizedBox(height: 20),
                  buildLevelButton(Level.medium),
                  const SizedBox(height: 20),
                  buildLevelButton(Level.hard),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showTutorial(Level currentLevel, int numberOfBox) {
    Widget buildColorTutorial(
        {required Widget puzzle, required String description}) {
      return Row(
        children: [
          puzzle,
          const SizedBox(width: 16),
          Expanded(
            child: Text(description,
                style:
                    WordleTypographyTheme.textStyleBold.copyWith(fontSize: 18)),
          ),
        ],
      );
    }

    int defaultNumberOfBox = 6;
    Get.generalDialog(
      pageBuilder: (context, _, __) {
        return GestureDetector(
          onTap: () async {
            await GetStorage()
                .write(WordlePreferenceKeys.showFirstTimeTutorial, true);
            Get.back();
          },
          child: Material(
            color: currentLevel.dialogBgColor.withOpacity(0.6),
            child: SafeArea(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: WordleConstant.horizontalPuzzlePadding / 2),
                children: [
                  const WordleTextWidget(size: 20),
                  const SizedBox(height: 20),
                  Text(
                    WordleText.howToPlay,
                    style: WordleTypographyTheme.textStyleBold
                        .copyWith(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(WordleText.instruction(numberOfBox),
                      style: WordleTypographyTheme.textStyleBold
                          .copyWith(fontSize: 18)),
                  const SizedBox(height: 20),
                  buildColorTutorial(
                    puzzle: Puzzle(
                      box: Box(
                          char: 'S', type: BoxType.existWithCorrectPosition),
                      numberOfBox: defaultNumberOfBox,
                    ),
                    description: WordleText.correctDescription,
                  ),
                  const SizedBox(height: 20),
                  buildColorTutorial(
                    puzzle: Puzzle(
                      box: Box(
                          char: 'M', type: BoxType.existWithIncorrectPosition),
                      numberOfBox: defaultNumberOfBox,
                    ),
                    description: WordleText.presentDescription,
                  ),
                  const SizedBox(height: 20),
                  buildColorTutorial(
                    puzzle: Puzzle(
                      box: Box(char: 'A', type: BoxType.notExist),
                      numberOfBox: defaultNumberOfBox,
                    ),
                    description: WordleText.absentDescription,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
