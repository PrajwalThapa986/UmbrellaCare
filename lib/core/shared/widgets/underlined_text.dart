import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';

class UnderlinedText extends StatelessWidget {
  const UnderlinedText({
    super.key,
    required this.text,
    // required this.gap,
  });

  final String text;
  // final double gap;

  @override
  Widget build(BuildContext context) {
    //! Text Painter
    //An object that paints a TextSpan tree into a Canvas.
    //! layout({double minWidth = 0.0, double maxWidth = double.infinity}) → void
    //Computes the visual position of the glyphs for painting the text.
    //* The cascade notation .. allows you to call the layout() method on the textPainter object immediately after its creation,..
    // without needing to explicitly reference textPainter again.
    //*  This method is crucial as it calculates the size and position of the text based on the provided constraints and style.
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTextStyle.buttonText,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        Text(
          text,
          style: AppTextStyle.textButton,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: textPainter.width,
            height: 1.5,
            color: AppColors.primary,
          ),
        )
      ],
    );
  }
}
