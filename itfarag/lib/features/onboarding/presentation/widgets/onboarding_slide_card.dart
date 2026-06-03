import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class OnboardingSlide {
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;
  final Color gradientColor;
  final IconData icon;

  const OnboardingSlide({
    required this.title,
    required this.titleAr,
    required this.description,
    required this.descriptionAr,
    required this.gradientColor,
    required this.icon,
  });
}

class OnboardingSlideCard extends StatefulWidget {
  final OnboardingSlide slide;
  final double pageOffset; // Offset of this page from current scroll view page (0.0 when fully active)

  const OnboardingSlideCard({
    super.key,
    required this.slide,
    required this.pageOffset,
  });

  @override
  State<OnboardingSlideCard> createState() => _OnboardingSlideCardState();
}

class _OnboardingSlideCardState extends State<OnboardingSlideCard> with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    // Smooth floating breathing animation for the icon
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final textDirection = Directionality.of(context);
    final double rtlMultiplier = textDirection == TextDirection.rtl ? -1.0 : 1.0;

    final title = isArabic ? widget.slide.titleAr : widget.slide.title;
    final description = isArabic ? widget.slide.descriptionAr : widget.slide.description;

    // Calculate parallax parameters based on the pageOffset
    // pageOffset ranges from -1.0 (swiped off-screen to the right) to 1.0 (swiped off-screen to the left)
    final double absOffset = widget.pageOffset.abs();
    final double opacity = (1.0 - absOffset * 1.5).clamp(0.0, 1.0);
    
    // Horizontal parallax translations
    final double iconTranslationX = widget.pageOffset * 180 * rtlMultiplier;
    final double textTranslationX = widget.pageOffset * 80 * rtlMultiplier;
    
    // Scale down items slightly when swiped out
    final double scale = (1.0 - absOffset * 0.25).clamp(0.75, 1.0);

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05),

            // 1. Central Animated Glowing Icon
            Transform.translate(
              offset: Offset(iconTranslationX, 0),
              child: Transform.scale(
                scale: scale,
                child: AnimatedBuilder(
                  animation: _floatAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _floatAnimation.value),
                      child: child,
                    );
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.slide.gradientColor.withOpacity(0.08),
                        border: Border.all(
                          color: widget.slide.gradientColor.withOpacity(0.25),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.slide.gradientColor.withOpacity(0.18),
                            blurRadius: 45,
                            spreadRadius: 8,
                          ),
                          // Subtle inner-shadow styled glow
                          BoxShadow(
                            color: widget.slide.gradientColor.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.slide.icon,
                        size: 90,
                        color: widget.slide.gradientColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.07),

            // 2. Parallax Texts inside Premium GlassCard
            Transform.translate(
              offset: Offset(textTranslationX, 0),
              child: Transform.scale(
                scale: scale,
                child: GlassCard(
                  borderRadius: 28,
                  blur: 25.0,
                  fillOpacity: 0.06,
                  borderOpacity: 0.12,
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top decorative glow bar
                      Container(
                        width: 45,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              widget.slide.gradientColor,
                              widget.slide.gradientColor.withOpacity(0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: isArabic ? 0.0 : -0.5,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.85),
                          height: 1.55,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.12),
          ],
        ),
      ),
    );
  }
}
