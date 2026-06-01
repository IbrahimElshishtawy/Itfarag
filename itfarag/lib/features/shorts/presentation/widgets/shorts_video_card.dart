// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import 'action_button.dart';
import 'spinning_audio_disc.dart';

class ShortsVideoCard extends StatefulWidget {
  final String videoUrl;
  final String creator;
  final String description;
  final String audio;
  final String likes;
  final String comments;
  final bool isFocused;

  const ShortsVideoCard({
    Key? key,
    required this.videoUrl,
    required this.creator,
    required this.description,
    required this.audio,
    required this.likes,
    required this.comments,
    required this.isFocused,
  }) : super(key: key);

  @override
  State<ShortsVideoCard> createState() => _ShortsVideoCardState();
}

class _ShortsVideoCardState extends State<ShortsVideoCard> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _showPlayIndicator = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
            _controller.setLooping(true);
            _controller.setVolume(1.0);
          });
          // Auto-play if initially focused
          if (widget.isFocused) {
            _controller.play();
            setState(() {
              _isPlaying = true;
            });
          }
        }
      });
  }

  @override
  void didUpdateWidget(covariant ShortsVideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      if (widget.isFocused) {
        _controller.play();
        setState(() {
          _isPlaying = true;
        });
      } else {
        _controller.pause();
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!_isInitialized) return;
    
    setState(() {
      if (_isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
      _showPlayIndicator = true;
    });

    // Auto-hide large center play/pause visual indicator
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _showPlayIndicator = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Video Renderer
          _isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),

          // Double tap / Single tap visual scale feedback indicator
          if (_showPlayIndicator)
            Center(
              child: AnimatedOpacity(
                opacity: _showPlayIndicator ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 350),
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.black45,
                  child: Icon(
                    _isPlaying ? Icons.play_arrow_rounded : Icons.pause_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),

          // Dynamic shading/gradient overlay for subtitle readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Buffering progress overlay
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, VideoPlayerValue value, child) {
              if (value.isBuffering) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.secondary),
                );
              }
              return const SizedBox();
            },
          ),

          // Creator details, title, sound labels
          Positioned(
            bottom: 30,
            left: 16,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=60'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.creator,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Follow', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.description,
                  style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.music_note_rounded, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.audio,
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Premium sidebar interactive buttons
          Positioned(
            bottom: 30,
            right: 16,
            child: Column(
              children: [
                ActionButton(icon: Icons.favorite_rounded, label: widget.likes, iconColor: AppColors.primary),
                const SizedBox(height: 20),
                ActionButton(icon: Icons.comment_rounded, label: widget.comments),
                const SizedBox(height: 20),
                ActionButton(icon: Icons.share_rounded, label: 'Share'),
                const SizedBox(height: 20),
                const SpinningAudioDisc(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
