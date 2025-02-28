import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';
import 'package:umbrella_care/core/extension/sized_box_extension.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.hideText = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.textFieldTitle,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String? value) validator;
  final bool hideText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final String? textFieldTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (textFieldTitle != null) ...{
          Text(
            textFieldTitle!,
            style: AppTextStyle.subTitleText,
          ),
          5.yGap,
        },
        TextFormField(
          controller: controller,
          obscureText: hideText,
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixIconPressed,
                    icon: Icon(
                      suffixIcon,
                      color: AppColors.primary,
                      size: 20.ts,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF5E1A84),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.greyFormBorder,
              ),
            ),
          ),
          style: AppTextStyle.regularText.copyWith(
            color: Colors.black,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
