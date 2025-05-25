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

class AppColorsDark {
  // background & surfaces
  static const Color background    = Color(0xFF1E1E2E); // very dark slate
  static const Color surface       = Color(0xFF2A2A3A); // cards & containers

  // accents (– keep brand hue but boost vibrancy)
  static const Color coral         = Color(0xFFFF7F70); // coral → brightened
  static const Color container     = Color(0xFF4C647D); // steel-blue → deeper
  static const Color green         = Color(0xFF6AA05A); // moss-green
  static const Color red           = Color(0xFFB34242); // wine-red
  static const Color blue          = Color(0xFF3A7ACF); // royal blue

  // browns (– a bit deeper)
  static const Color brownLight    = Color(0xFF83624F);
  static const Color brownDark     = Color(0xFF4A321F);

  // text & icons
  static const Color primaryText   = Color(0xFFE0E0E0); // near-white
  static const Color secondaryText = Color(0xFF9E9E9E); // mid-grey
  static const Color onAccentText  = Color(0xFF1E1E2E); // for text/icons over coral, container, etc.
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
        bodySmall: TextStyle(color: AppColors.lightText)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brownLight,
          foregroundColor: AppColors.darkText,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.background,
        secondary: AppColors.coral,
        tertiary: AppColors.green,
        tertiaryContainer: AppColorsDark.red
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.container,
        unselectedItemColor: AppColors.darkText,
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 6,
        activeTrackColor: AppColors.container,
        inactiveTrackColor: AppColors.container.withValues(alpha: 0.3),
        thumbColor: AppColors.container,
        overlayColor: AppColors.container.withValues(alpha: 0.2),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          valueIndicatorColor: AppColors.container
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsDark.background,
      primaryColor: AppColorsDark.container,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColorsDark.primaryText,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(color: AppColorsDark.primaryText),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColorsDark.primaryText),
        bodyMedium: TextStyle(color: AppColorsDark.primaryText),
          titleLarge: TextStyle(color: AppColorsDark.primaryText),
          titleMedium: TextStyle(color: AppColorsDark.primaryText),
          headlineMedium: TextStyle(color: AppColorsDark.primaryText),
          bodySmall: TextStyle(color: AppColorsDark.primaryText)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.brownLight,
          foregroundColor: AppColorsDark.secondaryText,
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColorsDark.background,
        secondary: AppColorsDark.coral,
          tertiary: AppColorsDark.green,
        tertiaryContainer: AppColorsDark.red
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorsDark.background,
        selectedItemColor: AppColorsDark.container,
        unselectedItemColor: AppColorsDark.secondaryText,
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 6,
        activeTrackColor: AppColorsDark.container,
        inactiveTrackColor: AppColorsDark.container.withValues(alpha: 0.3),
        thumbColor: AppColorsDark.container,
        overlayColor: AppColorsDark.container.withValues(alpha: 0.2),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          valueIndicatorColor: AppColorsDark.container
      ),

    );
  }
}