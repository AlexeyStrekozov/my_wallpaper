import 'package:flutter/material.dart';
import 'package:my_wallpaper/common/theme/src/main_theme.dart';

class LightTheme extends MainTheme {
  @override
  final colors = MainThemeColors(
    redError: const Color(0xFFDE6262),
    primaryDarkOrWhite: const Color(0xFF2E3448),
    primaryMain: const Color(0xFF4284E2),
    primaryLight: const Color(0xFF61A0ED),
    primaryExtraLight: const Color(0xFFF2F8FE),
    grayScaleBlack: const Color(0xFF2B2C30),
    grayScaleGray: const Color(0xFFB4B5BB),
    grayScaleLightGrey: const Color(0xFFD2D8DE),
    grayScaleWhiteOrBlack: const Color(0xFFFFFFFF),
    greenSuccess: const Color(0xFF75C678),
    bg: const Color(0xFFF2F2F2),
    logo: const Color(0xFF90D0F7),
    background: const Color(0xFFF2F2F2),
    borderDividers: const Color(0xFFE5EFF9),
    textSecondary: const Color(0xFFA6A8AC),
    yellow: const Color(0xFFFBAF1D),
    bgBlue: const Color(0xFFF3F9FF),
    bgRed: const Color(0xFFFEEEEF),
    appBackground: const Color(0xFFFFFFFF),
    whiteColor: const Color(0xFFFFFFFF),
    bgGray: const Color(0xFFF2F2F2),
  );

  @override
  final textStyles = MainThemeTextStyles(
    regular32: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    semiBold24: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.4,
    ),
    medium16: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
    ),
    medium14: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.4,
    ),
    medium12: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.4,
    ),
    regular16: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1.4,
    ),
    regular14: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 1.4,
    ),
    regular12: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 12,
      height: 1.2,
    ),
  );
}

class DarkTheme extends MainTheme {
  @override
  final colors = MainThemeColors(
    redError: const Color(0xFFDE6262),
    primaryDarkOrWhite: const Color(0xFFFFFFFF),
    primaryMain: const Color(0xFF4284E2),
    primaryLight: const Color(0xFF61A0ED),
    primaryExtraLight: const Color(0xFFF2F8FE),
    grayScaleBlack: const Color(0xFF2B2C30),
    grayScaleGray: const Color(0xFFB4B5BB),
    grayScaleLightGrey: const Color(0xFFD2D8DE),
    grayScaleWhiteOrBlack: const Color(0xFF212E41),
    bg: const Color(0xFF212E41),
    logo: const Color(0xFF90D0F7),
    greenSuccess: const Color(0xFF75C678),
    background: const Color(0xFFF2F2F2),
    borderDividers: const Color(0xFF2E3854),
    textSecondary: const Color(0xFFA6A8AC),
    yellow: const Color(0xFFFBAF1D),
    bgBlue: const Color(0xFFF3F9FF),
    bgRed: const Color(0xFFFEEEEF),
    appBackground: const Color(0xFF141929),
    whiteColor: const Color(0xFFFFFFFF),
    bgGray: const Color(0xFF212E41),
  );

  @override
  final textStyles = MainThemeTextStyles(
    regular32: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    semiBold24: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.4,
    ),
    medium16: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
    ),
    medium14: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.4,
    ),
    medium12: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.4,
    ),
    regular16: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1.4,
    ),
    regular14: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 1.4,
    ),
    regular12: const TextStyle(
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 12,
      height: 1.2,
    ),
  );
}
