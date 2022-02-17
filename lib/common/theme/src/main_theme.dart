import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeException implements Exception {
  final String message;

  ThemeException(this.message);

  @override
  String toString() => message;
}

abstract class MainTheme {
  MainThemeColors get colors;

  MainThemeTextStyles get textStyles;
}

class MainThemeColors {
  final Color redError;
  final Color primaryDarkOrWhite;
  final Color primaryMain;
  final Color primaryLight;
  final Color primaryExtraLight;
  final Color grayScaleBlack;
  final Color grayScaleGray;
  final Color grayScaleLightGrey;
  final Color grayScaleWhiteOrBlack;
  final Color bg;
  final Color logo;
  final Color background;
  final Color borderDividers;
  final Color textSecondary;
  final Color yellow;
  final Color bgBlue;
  final Color bgRed;
  final Color appBackground;
  final Color whiteColor;
  final Color greenSuccess;
  final Color bgGray;

  MainThemeColors({
    required this.redError,
    required this.primaryDarkOrWhite,
    required this.primaryMain,
    required this.primaryLight,
    required this.primaryExtraLight,
    required this.grayScaleBlack,
    required this.grayScaleGray,
    required this.grayScaleLightGrey,
    required this.grayScaleWhiteOrBlack,
    required this.bg,
    required this.logo,
    required this.greenSuccess,
    required this.background,
    required this.borderDividers,
    required this.textSecondary,
    required this.yellow,
    required this.bgBlue,
    required this.bgRed,
    required this.appBackground,
    required this.whiteColor,
    required this.bgGray,
  });
}

class MainThemeTextStyles {
  final TextStyle regular32;
  final TextStyle semiBold24;
  final TextStyle medium16;
  final TextStyle medium14;
  final TextStyle regular16;
  final TextStyle regular14;
  final TextStyle regular12;
  final TextStyle medium12;

  MainThemeTextStyles({
    required this.semiBold24,
    required this.medium16,
    required this.medium14,
    required this.medium12,
    required this.regular16,
    required this.regular14,
    required this.regular12,
    required this.regular32,
  });
}
