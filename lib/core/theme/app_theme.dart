import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      useMaterial3: false,
      //fontFamily: 'Poppins',
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColor.primary,
        onPrimary: isDark ? AppColor.onSurfaceDark : AppColor.onSurfaceLight,
        secondary: isDark ? AppColor.secondaryDark : AppColor.secondaryLight,
        onSecondary: isDark ? AppColor.onSurfaceDark : AppColor.onSurfaceLight,
        error: Colors.red,
        onError: Colors.white,
        surface: isDark ? AppColor.surfaceDark : AppColor.surfaceLight,
        onSurface: isDark ? AppColor.onSurfaceDark : AppColor.onSurfaceLight,
      ),
    );
  }
}
