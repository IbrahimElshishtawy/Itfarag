import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String userName;
  final String joinDate;
  final String levelText;
  final String avatarUrl;

  const ProfileHeaderCard({
    Key? key,
    required this.userName,
    required this.joinDate,
    required this.levelText,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: AppColors.premiumGradient,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
              // Level Badge Overlay (Diamond Level status)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Text(
                  levelText,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            userName,
            style: AppTypography.heading2.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            joinDate,
            style: AppTypography.bodySmall.copyWith(color: Colors.white54),
          ),
        ),
      ],
    );
  }
}
