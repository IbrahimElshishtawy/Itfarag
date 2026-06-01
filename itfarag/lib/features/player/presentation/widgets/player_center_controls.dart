// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class PlayerCenterControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPauseToggle;
  final VoidCallback onRewind;
  final VoidCallback onForward;

  const PlayerCenterControls({
    Key? key,
    required this.isPlaying,
    required this.onPlayPauseToggle,
    required this.onRewind,
    required this.onForward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 42),
          onPressed: onRewind,
        ),
        const SizedBox(width: 32),
        CircleAvatar(
          radius: 36,
          backgroundColor: Colors.white.withValues(alpha: 0.15),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 44,
            ),
            onPressed: onPlayPauseToggle,
          ),
        ),
        const SizedBox(width: 32),
        IconButton(
          icon: const Icon(Icons.forward_30_rounded, color: Colors.white, size: 42),
          onPressed: onForward,
        ),
      ],
    );
  }
}
