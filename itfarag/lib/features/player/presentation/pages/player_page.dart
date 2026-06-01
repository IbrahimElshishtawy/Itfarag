import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                                onPressed: () => context.pop(),
                              ),
                              Expanded(
                                child: Text(
                                  'Streaming: Tears of Steel (Sci-Fi VOD)',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
                                    ),
                                    child: const Text(
                                      'SERVER 1',
                                      style: TextStyle(color: AppColors.secondary, fontSize: 9, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Middle playback control buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 42),
                              onPressed: () {
                                final currentPos = _controller.value.position;
                                _controller.seekTo(currentPos - const Duration(seconds: 10));
                              },
                            ),
                            const SizedBox(width: 32),
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.white.withOpacity(0.15),
                              child: IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 44,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 32),
                            IconButton(
                              icon: const Icon(Icons.forward_30_rounded, color: Colors.white, size: 42),
                              onPressed: () {
                                final currentPos = _controller.value.position;
                                _controller.seekTo(currentPos + const Duration(seconds: 30));
                              },
                            ),
                          ],
                        ),

                        // Bottom progress and seek bar panel
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Skip Intro button seeking 2 minutes (120s)
                              if (_controller.value.position < const Duration(minutes: 2))
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GlassCard(
                                    borderRadius: 8,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    fillOpacity: 0.2,
                                    child: GestureDetector(
                                      onTap: () {
                                        _controller.seekTo(const Duration(minutes: 2));
                                      },
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
                                    _formatDuration(_controller.value.position),
                                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      value: _controller.value.position.inMilliseconds.toDouble(),
                                      min: 0.0,
                                      max: _controller.value.duration.inMilliseconds.toDouble(),
                                      onChanged: (val) {
                                        _controller.seekTo(Duration(milliseconds: val.toInt()));
                                      },
                                      activeColor: AppColors.primary,
                                      inactiveColor: Colors.white24,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(_controller.value.duration),
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
                                          _controller.value.volume > 0.0
                                              ? Icons.volume_up_rounded
                                              : Icons.volume_off_rounded,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _controller.setVolume(_controller.value.volume > 0.0 ? 0.0 : 1.0);
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'HLS Adaptive Bitrate Stream',
                                        style: TextStyle(color: Colors.white54, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.fullscreen_exit_rounded, color: Colors.white),
                                    onPressed: () => context.pop(),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
