// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/player_top_bar.dart';
import '../widgets/player_center_controls.dart';
import '../widgets/player_seek_panel.dart';

class PlayerPage extends StatefulWidget {
  final String id;

  const PlayerPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController _controller;
  bool _isControlsVisible = true;
  bool _isBuffering = false;

  // Real HLS Streaming Server URL - Tears of Steel (Sci-Fi Open Movie)
  static const String _streamUrl =
      'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8';

  @override
  void initState() {
    super.initState();
    // Initialize standard VideoPlayerController with a real streaming server HLS URI
    _controller = VideoPlayerController.networkUrl(Uri.parse(_streamUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
        _controller.play();
      });

    _controller.addListener(_videoPlayerListener);

    // Auto-hide controls overlay after 4 seconds
    _startControlsTimer();
  }

  void _videoPlayerListener() {
    if (_controller.value.isBuffering != _isBuffering) {
      setState(() {
        _isBuffering = _controller.value.isBuffering;
      });
    }
    // Repaint to update the custom slider progress
    setState(() {});
  }

  void _startControlsTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() {
          _isControlsVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isControlsVisible = !_isControlsVisible;
          });
          if (_isControlsVisible) {
            _startControlsTimer();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // Video Renderer Frame
            _controller.value.isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.primary),
                        SizedBox(height: 16),
                        Text(
                          'Connecting to Streaming Server...',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

            // Buffering Overlay Indicator
            if (_isBuffering)
              Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.secondary),
                ),
              ),

            // Controls Overlay UI Layer
            AnimatedOpacity(
              opacity: _isControlsVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: !_isControlsVisible,
                child: Container(
                  color: Colors.black45,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Top bar controls
                        PlayerTopBar(
                          title: 'Streaming: Tears of Steel (Sci-Fi VOD)',
                          onBackPressed: () => context.pop(),
                        ),

                        // Middle playback control buttons
                        PlayerCenterControls(
                          isPlaying: _controller.value.isPlaying,
                          onPlayPauseToggle: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          onRewind: () {
                            final currentPos = _controller.value.position;
                            _controller.seekTo(currentPos - const Duration(seconds: 10));
                          },
                          onForward: () {
                            final currentPos = _controller.value.position;
                            _controller.seekTo(currentPos + const Duration(seconds: 30));
                          },
                        ),

                        // Bottom progress and seek bar panel
                        PlayerSeekPanel(
                          currentPosition: _controller.value.position,
                          totalDuration: _controller.value.duration,
                          currentVolume: _controller.value.volume,
                          onSeekChanged: (val) {
                            _controller.seekTo(Duration(milliseconds: val.toInt()));
                          },
                          onVolumeToggle: () {
                            _controller.setVolume(_controller.value.volume > 0.0 ? 0.0 : 1.0);
                          },
                          onFullscreenExit: () => context.pop(),
                          onSkipIntro: () {
                            _controller.seekTo(const Duration(minutes: 2));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
