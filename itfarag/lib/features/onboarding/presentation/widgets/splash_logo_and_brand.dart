import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class SplashLogoAndBrand extends StatelessWidget {
  const SplashLogoAndBrand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Premium Glassmorphic App Icon Container
        GlassCard(
          borderRadius: 28,
          padding: const EdgeInsets.all(12),
          fillOpacity: 0.15,
          borderOpacity: 0.25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/app_icon.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ETFARAG',
          style: AppTypography.heading1.copyWith(
            fontSize: 40,
            letterSpacing: 3,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: AppColors.premiumGradient,
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
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
    );
  }
}
