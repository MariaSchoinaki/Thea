import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF1F6FF);
  static const Color coral = Color(0xFFE65C4F);
  static const Color container = Color(0xFF78A6C8);
  static const Color green = Color(0xFF7EC878);
  static const Color red = Color(0xFFD24545);
  static const Color blue = Color(0xFF4399FD);

  static const Color brownLight = Color(0xFFC89A78);
  static const Color brownDark = Color(0xFF6C4E31);

  static const Color grey = Color(0xFF4A4A4A);
  static const Color darkText = Colors.black87;
  static const Color lightText = Colors.white;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.container,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.darkText,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(color: AppColors.darkText),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkText),
        bodyMedium: TextStyle(color: AppColors.darkText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.container,
          foregroundColor: AppColors.lightText,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.background,
        secondary: AppColors.coral,
      ),
    );
  }
}