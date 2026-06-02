import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_slide_card.dart';
import '../widgets/onboarding_navigation_controls.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

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
                  _slides[_currentIndex].gradientColor.withValues(alpha: 0.08),
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
              return OnboardingSlideCard(slide: _slides[index]);
            },
          ),
          // Navigation controls
          OnboardingNavigationControls(
            currentIndex: _currentIndex,
            slidesCount: _slides.length,
            nextButtonText: _currentIndex == _slides.length - 1 ? 'Get Started' : 'Next',
            onNextPressed: () {
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
        ],
      ),
    );
  }
}
