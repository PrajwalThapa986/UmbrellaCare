import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  const PrimaryOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          side: const BorderSide(color: AppColors.primary),
        ),
        child: Text(
          text,
          style: AppTextStyle.buttonText.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
