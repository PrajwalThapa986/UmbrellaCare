import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';
import 'package:umbrella_care/core/extension/sized_box_extension.dart';

class ExtendedTextButton extends StatelessWidget {
  const ExtendedTextButton({
    super.key,
    required this.prefixText,
    required this.buttonText,
    required this.onPressed,
  });

  final String prefixText;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          prefixText,
          style: AppTextStyle.subTitleText,
        ),
        5.xGap,
        InkWell(
          onTap: onPressed,
          child: UnderlinedText(text: buttonText),
        ),
      ],
    );
  }
}
