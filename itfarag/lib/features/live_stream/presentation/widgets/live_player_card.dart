// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';

class LivePlayerCard extends StatelessWidget {
  final bool isInitialized;
  final bool isPlaying;
  final bool isBuffering;
  final VideoPlayerController controller;
  final VoidCallback onTogglePlay;

  const LivePlayerCard({
    Key? key,
    required this.isInitialized,
    required this.isPlaying,
    required this.isBuffering,
    required this.controller,
    required this.onTogglePlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // Video Render Frame
            isInitialized
                ? GestureDetector(
                    onTap: onTogglePlay,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.primary),
                        SizedBox(height: 12),
                        Text(
                          'Connecting to Broadcast Stream...',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

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
                    child: Row(
                      children: const [
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
        ),
      ),
    );
  }
}
