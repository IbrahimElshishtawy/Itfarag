import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LivePlayerOverlay extends StatelessWidget {
  final bool isInitialized;
  final bool isPlaying;
  final bool isBuffering;
  final VoidCallback onTogglePlay;

  const LivePlayerOverlay({
    super.key,
    required this.isInitialized,
    required this.isPlaying,
    required this.isBuffering,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark overlay at top for better view of LIVE badges
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 60,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Live & Viewers badges
        Positioned(
          top: 12,
          left: 12,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('LIVE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.remove_red_eye_rounded, color: Colors.white, size: 10),
                    SizedBox(width: 4),
                    Text('14.2K', style: TextStyle(fontSize: 10, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Manual Play/Pause Quick Tap overlay
        if (isInitialized && !isPlaying)
          GestureDetector(
            onTap: onTogglePlay,
            child: Container(
              color: Colors.black45,
              child: const Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
                ),
              ),
            ),
          ),

        // Buffering Indicator overlay
        if (isBuffering)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            ),
          ),
      ],
    );
  }
}
