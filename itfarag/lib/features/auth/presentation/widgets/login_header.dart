import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/app_icon.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'ETFARAG',
            style: AppTypography.heading1.copyWith(
              fontSize: 32,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: AppColors.premiumGradient,
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Unlock unlimited movies, series, and Watch Parties',
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(color: Colors.white54),
        ),
      ],
    );
  }
}
