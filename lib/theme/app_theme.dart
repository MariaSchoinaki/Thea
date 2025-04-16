import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFFFAF6);
  static const Color orange = Color(0xFFFF7043);
  static const Color container = Color(0xFF9DBBD8);
  static const Color green = Color(0xFF5DAE8B);
  static const Color red = Color(0xFFD72638);
  static const Color blue = Color(0xFF4399FD);
  static const Color grey = Color(0xFF4A4A4A);
  static const Color darkText = Colors.black87;
  static const Color lightText = Colors.white;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.orange,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.darkText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.orange,
        secondary: AppColors.container,
      ),
    );
  }
}
