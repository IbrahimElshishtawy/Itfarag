// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import 'shorts_description_panel.dart';
import 'shorts_sidebar_actions.dart';

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
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
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
          ShortsDescriptionPanel(
            creator: widget.creator,
            description: widget.description,
            audio: widget.audio,
          ),
          ShortsSidebarActions(
            likes: widget.likes,
            comments: widget.comments,
          ),
        ],
      ),
    );
  }
}
