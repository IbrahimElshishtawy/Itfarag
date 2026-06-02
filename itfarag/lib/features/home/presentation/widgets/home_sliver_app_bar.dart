import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black87;

    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: (isDark ? AppColors.darkBackground : AppColors.lightBackground).withValues(alpha: 0.8),
      title: Text(
        'ETFARAG',
        style: AppTypography.heading2.copyWith(
          fontSize: 24,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: AppColors.premiumGradient,
            ).createShader(const Rect.fromLTWH(0.0, 0.0, 150.0, 40.0)),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none_rounded, color: iconColor),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.cast_connected_rounded, color: iconColor),
          onPressed: () {},
        ),
      ],
    );
  }
}
