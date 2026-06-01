import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: AppColors.darkBackground.withOpacity(0.8),
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
          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.cast_connected_rounded, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
