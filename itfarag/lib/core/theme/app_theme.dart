import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,
      cardColor: AppColors.darkCard,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.heading1.copyWith(color: Colors.white),
        headlineMedium: AppTypography.heading2.copyWith(color: Colors.white),
        headlineSmall: AppTypography.heading3.copyWith(color: Colors.white),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.white70),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: Colors.white60),
        bodySmall: AppTypography.bodySmall.copyWith(color: Colors.white54),
        labelLarge: AppTypography.buttonText.copyWith(color: Colors.white),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primary,
      cardColor: AppColors.lightCard,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.lightSurface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.heading1.copyWith(color: Colors.black87),
        headlineMedium: AppTypography.heading2.copyWith(color: Colors.black87),
        headlineSmall: AppTypography.heading3.copyWith(color: Colors.black87),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.black87),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: Colors.black54),
        bodySmall: AppTypography.bodySmall.copyWith(color: Colors.black38),
        labelLarge: AppTypography.buttonText.copyWith(color: Colors.black87),
      ),
    );
  }
}
