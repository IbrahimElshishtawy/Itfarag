import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/premium_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingSlide> _slides = [
    const OnboardingSlide(
      title: 'Ultra Premium Library',
      description: 'Stream unlimited 4K Dolby Atmos Movies, Series, Live TV, and exclusive Content Creators.',
      gradientColor: AppColors.primary,
      icon: Icons.movie_filter_rounded,
    ),
    const OnboardingSlide(
      title: 'AI Smart Feed & Mood Match',
      description: 'Interact with our advanced AI engine to fetch dynamic lists of video content customized exactly to your mood.',
      gradientColor: AppColors.secondary,
      icon: Icons.psychology_rounded,
    ),
    const OnboardingSlide(
      title: 'Watch Party Together',
      description: 'Enjoy perfectly synchronized streaming playback with real-time video chat reactions and audio call feeds.',
      gradientColor: AppColors.accent,
      icon: Icons.groups_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Color Flow
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.darkBackgroundGradient[0],
                  _slides[_currentIndex].gradientColor.withOpacity(0.08),
                  AppColors.darkBackgroundGradient[1],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              final slide = _slides[index];
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
            },
          ),
          // Navigation controls
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dots indicator
                Row(
                  children: List.generate(
                    _slides.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentIndex == index
                            ? AppColors.primary
                            : Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
                // Premium Next Button
                SizedBox(
                  width: 140,
                  child: PremiumButton(
                    text: _currentIndex == _slides.length - 1 ? 'Get Started' : 'Next',
                    onPressed: () {
                      if (_currentIndex < _slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.goNamed(RouteNames.login);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
