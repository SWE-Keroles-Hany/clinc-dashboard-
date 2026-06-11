import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: ColorManager.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
    ),

    scaffoldBackgroundColor: ColorManager.white,
  );
}
