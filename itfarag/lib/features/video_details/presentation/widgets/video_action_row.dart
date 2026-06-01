import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/premium_button.dart';

class VideoActionRow extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onDownloadPressed;

  const VideoActionRow({
    Key? key,
    required this.onPlayPressed,
    required this.onDownloadPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PremiumButton(
            text: 'Play Stream',
            icon: Icons.play_arrow_rounded,
            onPressed: onPlayPressed,
          ),
        ),
        const SizedBox(width: 12),
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white.withOpacity(0.05),
          child: IconButton(
            icon: const Icon(Icons.download_rounded, color: AppColors.secondary),
            onPressed: onDownloadPressed,
          ),
        ),
      ],
    );
  }
}
