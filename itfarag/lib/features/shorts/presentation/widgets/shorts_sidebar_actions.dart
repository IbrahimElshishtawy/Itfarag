import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'action_button.dart';
import 'spinning_audio_disc.dart';

class ShortsSidebarActions extends StatelessWidget {
  final String likes;
  final String comments;

  const ShortsSidebarActions({
    super.key,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 16,
      child: Column(
        children: [
          ActionButton(icon: Icons.favorite_rounded, label: likes, iconColor: AppColors.primary),
          const SizedBox(height: 20),
          ActionButton(icon: Icons.comment_rounded, label: comments),
          const SizedBox(height: 20),
          const ActionButton(icon: Icons.share_rounded, label: 'Share'),
          const SizedBox(height: 20),
          const SpinningAudioDisc(),
        ],
      ),
    );
  }
}
