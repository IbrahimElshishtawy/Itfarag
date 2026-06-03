import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/premium_button.dart';

class OnboardingNavigationControls extends StatelessWidget {
  final int currentIndex;
  final int slidesCount;
  final String nextButtonText;
  final String skipButtonText;
  final Color activeColor;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;

  const OnboardingNavigationControls({
    super.key,
    required this.currentIndex,
    required this.slidesCount,
    required this.nextButtonText,
    required this.skipButtonText,
    required this.activeColor,
    required this.onNextPressed,
    required this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Positioned(
      bottom: size.height * 0.05,
      left: 24,
      right: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row of Dots Indicator & Skip Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dots indicator with custom activeColor transitions
              Row(
                children: List.generate(
                  slidesCount,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.only(right: 8),
                    height: 8,
                    width: currentIndex == index ? 28 : 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: currentIndex == index
                          ? activeColor
                          : (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                      boxShadow: currentIndex == index
                          ? [
                              BoxShadow(
                                color: activeColor.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),

              // Skip text button (Hidden on the final slide)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: currentIndex == slidesCount - 1 ? 0.0 : 1.0,
                child: IgnorePointer(
                  ignoring: currentIndex == slidesCount - 1,
                  child: TextButton(
                    onPressed: onSkipPressed,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      foregroundColor: isDark ? Colors.white60 : Colors.black54,
                    ),
                    child: Text(
                      skipButtonText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: isArabic ? 0.0 : 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Main Premium Action Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: PremiumButton(
              text: nextButtonText,
              onPressed: onNextPressed,
              icon: currentIndex == slidesCount - 1
                  ? Icons.rocket_launch_rounded
                  : (isArabic ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
