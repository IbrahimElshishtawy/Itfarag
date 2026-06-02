import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String userName;
  final String joinDate;
  final String levelText;
  final String avatarUrl;

  const ProfileHeaderCard({
    super.key,
    required this.userName,
    required this.joinDate,
    required this.levelText,
    required this.avatarUrl,
  });

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
                      color: AppColors.secondary.withValues(alpha: 0.4),
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
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            joinDate,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
