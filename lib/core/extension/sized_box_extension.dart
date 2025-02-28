import 'package:flutter/material.dart';
import 'package:umbrella_care/core/app_core.dart';

extension SizedBoxExtension on num {
  SizedBox get xGap => SizedBox(
        width: toDouble().w,
      );

  SizedBox get yGap => SizedBox(
        height: toDouble().h,
      );
}
