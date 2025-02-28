import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
        child: isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: SizedBox(
                  height: 16.w,
                  width: 16.w,
                  child: const CupertinoActivityIndicator(),
                ),
              )
            : Text(
                text,
                style: AppTextStyle.buttonText,
              ),
      ),
    );
  }
}
