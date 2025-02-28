import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';
import 'package:umbrella_care/core/constants/constants.dart';

class AppTextStyle {
  static final _appTextStyleInstance = AppTextStyle._();

  AppTextStyle._();

  factory AppTextStyle() => _appTextStyleInstance;

  //! copy with method
  //here the copy with method gets called itself as its defined in the TextStyle class of flutter.
  static TextStyle get headerText => TextStyle(
        fontSize: 30.ts,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      );

  static TextStyle get regularText => TextStyle(
        fontSize: 16.ts,
        color: AppColors.primary,
      );

  static TextStyle get buttonText => TextStyle(
        fontSize: 16.ts,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get subTitleText => TextStyle(
        fontSize: 14.ts,
        color: AppColors.primary,
      );

  static TextStyle get textButton => TextStyle(
        fontSize: 14.ts,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      );
}
