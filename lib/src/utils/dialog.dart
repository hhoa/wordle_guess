import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wordle_guess/src/constant/constant.dart';
import 'package:wordle_guess/src/constant/keys.dart';
import 'package:wordle_guess/src/enum/box.dart';
import 'package:wordle_guess/src/resources/colors.dart';
import 'package:wordle_guess/src/resources/strings.dart';
import 'package:wordle_guess/src/widgets/puzzle.dart';
import 'package:wordle_guess/src/widgets/row_puzzle.dart';
import 'package:wordle_guess/src/widgets/wordle_text.dart';

import '../model/box.dart';
import '../pages/home/wordle_button.dart';
import '../resources/typography.dart';

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
      {required Boxes correctWord, required VoidCallback onNext}) {
    Get.generalDialog(
      pageBuilder: (context, _, __) {
        return Material(
          color: WordleColors.deepBlue.withOpacity(0.7),
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
                RowPuzzle(boxes: correctWord),
                const SizedBox(height: 20),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: WordleConstant.horizontalPuzzlePadding / 2),
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

  static void showTutorial() {
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

    Get.generalDialog(
      pageBuilder: (context, _, __) {
        return GestureDetector(
          onTap: () async {
            await GetStorage().write(WordleKeys.showFirstTimeTutorial, true);
            Get.back();
          },
          child: Material(
            color: WordleColors.deepBlue.withOpacity(0.7),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: WordleConstant.horizontalPuzzlePadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Text(WordleText.instruction,
                        style: WordleTypographyTheme.textStyleBold
                            .copyWith(fontSize: 18)),
                    const SizedBox(height: 20),
                    buildColorTutorial(
                      puzzle: Puzzle(
                          box: Box(
                              char: 'S',
                              type: BoxType.existWithCorrectPosition)),
                      description: WordleText.correctDescription,
                    ),
                    const SizedBox(height: 20),
                    buildColorTutorial(
                      puzzle: Puzzle(
                          box: Box(
                              char: 'M',
                              type: BoxType.existWithIncorrectPosition)),
                      description: WordleText.presentDescription,
                    ),
                    const SizedBox(height: 20),
                    buildColorTutorial(
                      puzzle:
                          Puzzle(box: Box(char: 'A', type: BoxType.notExist)),
                      description: WordleText.absentDescription,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
