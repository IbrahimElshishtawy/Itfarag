// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'live_player_connecting.dart';
import 'live_player_overlay.dart';

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
            isInitialized
                ? GestureDetector(
                    onTap: onTogglePlay,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                : const LivePlayerConnecting(),
            LivePlayerOverlay(
              isInitialized: isInitialized,
              isPlaying: isPlaying,
              isBuffering: isBuffering,
              onTogglePlay: onTogglePlay,
            ),
          ],
        ),
      ),
    );
  }
}
