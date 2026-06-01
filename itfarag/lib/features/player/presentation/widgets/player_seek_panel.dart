// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class PlayerSeekPanel extends StatelessWidget {
  final Duration currentPosition;
  final Duration totalDuration;
  final double currentVolume;
  final ValueChanged<double> onSeekChanged;
  final VoidCallback onVolumeToggle;
  final VoidCallback onFullscreenExit;
  final VoidCallback onSkipIntro;

  const PlayerSeekPanel({
    Key? key,
    required this.currentPosition,
    required this.totalDuration,
    required this.currentVolume,
    required this.onSeekChanged,
    required this.onVolumeToggle,
    required this.onFullscreenExit,
    required this.onSkipIntro,
  }) : super(key: key);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Skip Intro button seeking 2 minutes (120s)
          if (currentPosition < const Duration(minutes: 2))
            Align(
              alignment: Alignment.centerRight,
              child: GlassCard(
                borderRadius: 8,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                fillOpacity: 0.2,
                child: GestureDetector(
                  onTap: onSkipIntro,
                  child: const Text(
                    'Skip Intro ⏩',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),

          // Timeline & Slider Seek controls
          Row(
            children: [
              Text(
                _formatDuration(currentPosition),
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              Expanded(
                child: Slider(
                  value: currentPosition.inMilliseconds.toDouble(),
                  min: 0.0,
                  max: totalDuration.inMilliseconds.toDouble().clamp(0.0, double.infinity),
                  onChanged: onSeekChanged,
                  activeColor: AppColors.primary,
                  inactiveColor: Colors.white24,
                ),
              ),
              Text(
                _formatDuration(totalDuration),
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      currentVolume > 0.0
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      color: Colors.white,
                    ),
                    onPressed: onVolumeToggle,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'HLS Adaptive Bitrate Stream',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.fullscreen_exit_rounded, color: Colors.white),
                onPressed: onFullscreenExit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
