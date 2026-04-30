import 'package:flutter/material.dart';
import 'package:movies_app/core/themes/colors/app_colors.dart';

class AppTheme {
  // ── Dark Theme ──────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    primaryColor: AppColors.primaryColor,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      surface: AppColors.secondaryColor,
      onSurface: AppColors.textPrimary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundColorDark,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.iconColor,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.white70),
      bodySmall: TextStyle(color: AppColors.iconColor),
    ),
  );

  // ── Light Theme ──────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    primaryColor: AppColors.primaryColor,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      surface: AppColors.textPrimary,
      onSurface: AppColors.secondaryColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorLight,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.backgroundColorDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.backgroundColorDark),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.textPrimary,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.secondaryColor,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.backgroundColorDark),
      bodyMedium: TextStyle(color: AppColors.backgroundColorDark),
      bodySmall: TextStyle(color: AppColors.secondaryColor),
    ),
  );
}
