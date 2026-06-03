// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_slide_card.dart';
import '../widgets/onboarding_navigation_controls.dart';
import '../widgets/cinematic_background.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  double _pageScrollOffset = 0.0;

  final List<OnboardingSlide> _slides = [
    const OnboardingSlide(
      title: 'Ultra Premium Library',
      titleAr: 'مكتبة ترفيهية متكاملة',
      description: 'Stream unlimited 4K Dolby Atmos Movies, Series, Live TV, and exclusive Content Creators.',
      descriptionAr: 'استمتع بمشاهدة غير محدودة بدقة 4K وصوت Dolby Atmos المحيطي للأفلام والمسلسلات والبث المباشر.',
      gradientColor: AppColors.primary,
      icon: Icons.movie_filter_rounded,
    ),
    const OnboardingSlide(
      title: 'AI Smart Feed & Mood Match',
      titleAr: 'توصيات ذكية تناسب مزاجك',
      description: 'Interact with our advanced AI engine to fetch dynamic lists of video content customized exactly to your mood.',
      descriptionAr: 'دع ذكاءنا الاصطناعي يقترح عليك قوائم عرض مخصصة وديناميكية تناسب حالتك المزاجية تماماً.',
      gradientColor: AppColors.secondary,
      icon: Icons.psychology_rounded,
    ),
    const OnboardingSlide(
      title: 'Watch Party Together',
      titleAr: 'مشاهدة جماعية ممتعة',
      description: 'Enjoy perfectly synchronized streaming playback with real-time video chat reactions and audio call feeds.',
      descriptionAr: 'شاهد محتواك المفضل بشكل متزامن تماماً مع أصدقائك مع مكالمات صوتية وتفاعلات مباشرة.',
      gradientColor: AppColors.accent,
      icon: Icons.groups_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    if (_pageController.hasClients) {
      setState(() {
        _pageScrollOffset = _pageController.page ?? 0.0;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    
    // Determine dynamic UI texts based on locale
    final String skipText = isArabic ? 'تخطي' : 'Skip';
    final String getStartedText = isArabic ? 'ابدأ الآن' : 'Get Started';
    final String nextText = isArabic ? 'التالي' : 'Next';

    return Scaffold(
      body: Stack(
        children: [
          // 1. Cinematic Background with scrolling columns and glassmorphism
          const Positioned.fill(
            child: CinematicBackground(),
          ),

          // 2. Ambient Gradient glow tied to the active slide's color
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    _slides[_currentIndex].gradientColor.withOpacity(0.12),
                    Colors.transparent,
                  ],
                  center: Alignment.center,
                  radius: 1.0,
                ),
              ),
            ),
          ),

          // 3. Slides PageView builder
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                // Compute individual page offsets for parallax calculation
                final double itemOffset = _pageScrollOffset - index;
                return OnboardingSlideCard(
                  slide: _slides[index],
                  pageOffset: itemOffset,
                );
              },
            ),
          ),

          // 4. Custom Navigation controls
          OnboardingNavigationControls(
            currentIndex: _currentIndex,
            slidesCount: _slides.length,
            nextButtonText: _currentIndex == _slides.length - 1 ? getStartedText : nextText,
            skipButtonText: skipText,
            activeColor: _slides[_currentIndex].gradientColor,
            onNextPressed: () {
              if (_currentIndex < _slides.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.fastOutSlowIn,
                );
              } else {
                context.goNamed(RouteNames.login);
              }
            },
            onSkipPressed: () {
              context.goNamed(RouteNames.login);
            },
          ),
        ],
      ),
    );
  }
}
