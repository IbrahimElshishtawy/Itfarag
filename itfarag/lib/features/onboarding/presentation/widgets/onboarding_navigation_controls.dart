import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/premium_button.dart';

class OnboardingNavigationControls extends StatelessWidget {
  final int currentIndex;
  final int slidesCount;
  final String nextButtonText;
  final VoidCallback onNextPressed;

  const OnboardingNavigationControls({
    super.key,
    required this.currentIndex,
    required this.slidesCount,
    required this.nextButtonText,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 24,
      right: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dots indicator
          Row(
            children: List.generate(
              slidesCount,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: currentIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: currentIndex == index
                      ? AppColors.primary
                      : Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          // Premium Next Button
          SizedBox(
            width: 140,
            child: PremiumButton(
              text: nextButtonText,
              onPressed: onNextPressed,
            ),
          ),
        ],
      ),
    );
  }
}
