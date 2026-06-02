import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFFE50914); // Electric Neon Red
  static const Color primaryLight = Color(0xFFFF3E4D);
  static const Color secondary = Color(0xFF00D2FF); // Cyberpunk Cyan
  static const Color accent = Color(0xFF8A2BE2); // Premium Purple (Glassmorphic glow)

  // Dark Theme Colors (Main Priority for Premium Feel)
  static const Color darkBackground = Color(0xFF0F0E13); // Midnight Velvet Black
  static const Color darkSurface = Color(0xFF1D1B26); // Deeper Surface
  static const Color darkCard = Color(0xFF252330);
  
  // Light Theme Colors (Clean & Dynamic)
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFE8EAF6);

  // Status & Utility Colors
  static const Color error = Color(0xFFFF3333);
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFD600);
  static const Color info = Color(0xFF29B6F6);

  // Glassmorphic Gradients
  static List<Color> get premiumGradient => [
        primary,
        accent,
        secondary,
      ];

  static List<Color> get glassmorphicBorder => [
        Colors.white.withValues(alpha: 0.15),
        Colors.white.withValues(alpha: 0.05),
      ];

  static List<Color> get darkBackgroundGradient => [
        const Color(0xFF09080C),
        const Color(0xFF151221),
      ];
}
