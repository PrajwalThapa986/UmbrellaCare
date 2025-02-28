import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';

class SnackbarUtils {
  static void showErrorBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        content: Text(
          message,
        ),
      ),
    );
  }

  static void showSuccessBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.success,
        content: Text(
          message,
        ),
      ),
    );
  }

  static void showWarningBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.warning,
        content: Text(
          message,
        ),
      ),
    );
  }
}
