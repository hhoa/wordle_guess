import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../resources/typography.dart';

class WordleTextWidget extends StatelessWidget {
  const WordleTextWidget({this.size = 36, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: WordleConstant.splashChars
          .map(
            (splash) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  color: splash.color,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(-2, 4))
                  ]),
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              child: Text(
                splash.char,
                style:
                    WordleTypographyTheme.textStyleBold.copyWith(fontSize: size / 2),
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }
}
