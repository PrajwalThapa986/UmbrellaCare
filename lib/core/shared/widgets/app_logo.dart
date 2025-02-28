import 'package:flutter/material.dart';
import 'package:umbrella_care/core/constants/assets.dart';
import 'package:umbrella_care/core/extension/extensions.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.umbrellaCareLogo,
      width: 250.h,
      height: 250.h,
      fit: BoxFit.cover,
    );
  }
}
