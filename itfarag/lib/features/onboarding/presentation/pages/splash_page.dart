import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeIn)),
    );

    _controller.forward();

    // Emulate check login session and redirect
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.goNamed(RouteNames.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.darkBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient premium backgrounds glow
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 100,
                      spreadRadius: 50,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.12),
                      blurRadius: 80,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Premium Glassmorphic Logo Container
                    GlassCard(
                      borderRadius: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: Text(
                        'ETFARAG',
                        style: AppTypography.heading1.copyWith(
                          fontSize: 48,
                          letterSpacing: 3,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: AppColors.premiumGradient,
                            ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'The Future of Entertainment Streaming',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white60,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 40,
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
