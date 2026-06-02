import 'package:flutter/material.dart';

class PlayerVolumeAndSpecs extends StatelessWidget {
  final double currentVolume;
  final VoidCallback onVolumeToggle;
  final VoidCallback onFullscreenExit;

  const PlayerVolumeAndSpecs({
    super.key,
    required this.currentVolume,
    required this.onVolumeToggle,
    required this.onFullscreenExit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
