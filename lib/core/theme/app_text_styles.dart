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
  static TextStyle get s18bold => const TextStyle(
    color: ColorManager.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}
