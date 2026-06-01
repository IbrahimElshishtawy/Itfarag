import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class OnboardingSlide {
  final String title;
  final String description;
  final Color gradientColor;
  final IconData icon;

  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.gradientColor,
    required this.icon,
  });
}

class OnboardingSlideCard extends StatelessWidget {
  final OnboardingSlide slide;

  const OnboardingSlideCard({
    Key? key,
    required this.slide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          // Ambient Light Icon Glow
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: slide.gradientColor.withOpacity(0.1),
              border: Border.all(
                color: slide.gradientColor.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: slide.gradientColor.withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              slide.icon,
              size: 80,
              color: slide.gradientColor,
            ),
          ),
          const SizedBox(height: 60),
          GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  slide.title,
                  textAlign: TextAlign.center,
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  slide.description,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
