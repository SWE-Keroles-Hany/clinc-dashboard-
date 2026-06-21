import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle get s40bold => const TextStyle(
    color: ColorManager.primary,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get s20bold => const TextStyle(
    color: ColorManager.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get s30bold => const TextStyle(
    color: ColorManager.primary,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get s18bold => const TextStyle(
    color: ColorManager.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get s14bold => const TextStyle(
    color: ColorManager.black,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get s16bold => const TextStyle(
    color: ColorManager.kGray500,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  //! patient theme text styles
  static TextStyle get heading1 => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ColorManager.textDark,
  );
  static TextStyle get heading2 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorManager.textDark,
  );
  static TextStyle get heading3 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorManager.textDark,
  );
  static TextStyle get bodyText =>
      const TextStyle(fontSize: 14, color: ColorManager.textDark, height: 1.5);
  static TextStyle get subtitleText =>
      const TextStyle(fontSize: 14, color: ColorManager.textLight);
  static TextStyle get labelText => const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: ColorManager.textLight,
    letterSpacing: 0.5,
  );
}
