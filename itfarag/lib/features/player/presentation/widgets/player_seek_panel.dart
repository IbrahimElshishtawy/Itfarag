// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'player_skip_intro_button.dart';
import 'player_volume_and_specs.dart';

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
          PlayerSkipIntroButton(
            currentPosition: currentPosition,
            onSkipIntro: onSkipIntro,
          ),
          const SizedBox(height: 12),
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
          PlayerVolumeAndSpecs(
            currentVolume: currentVolume,
            onVolumeToggle: onVolumeToggle,
            onFullscreenExit: onFullscreenExit,
          ),
        ],
      ),
    );
  }
}
