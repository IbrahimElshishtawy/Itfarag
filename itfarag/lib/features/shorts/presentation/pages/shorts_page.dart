// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({Key? key}) : super(key: key);

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  final PageController _pageController = PageController();
  int _focusedIndex = 0;

  // Vibrant cyberpunk and sci-fi high-quality vertical preview feeds from Mixkit
  final List<Map<String, String>> _shortsData = [
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-light-in-a-cyberpunk-ambiance-34283-large.mp4',
      'creator': '@Sara_VFX',
      'description': 'AI Green-screen VFX Breakdown: Transforming simple greenscreen clips into beautiful cyberpunk metropolitan skylines! 🦾✨ #cyberpunk #vfx',
      'audio': 'Original Audio - Sara_VFX',
      'likes': '34.2K',
      'comments': '1.2K',
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-cyberpunk-neon-city-street-with-people-and-lights-34281-large.mp4',
      'creator': '@Neon_Explorer',
      'description': 'Tokyo Nights in 2026: Immersive street level neon reflections and futuristic urban aesthetics. 🌆🚀 #streetwear #tokyo',
      'audio': 'Midnight Synthwave - Retrowave Records',
      'likes': '48.9K',
      'comments': '2.1K',
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-tunnel-of-futuristic-blue-neon-lights-34287-large.mp4',
      'creator': '@SciFi_Portals',
      'description': 'Entering the Matrix! Infinite neon blue tunnel loop. Perfect backdrop for synthwave lovers. 🌌🌀 #matrix #futuristic',
      'audio': 'Ambient Soundscape - SciFi_Portals',
      'likes': '29.1K',
      'comments': '840',
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            _focusedIndex = index;
          });
        },
        itemCount: _shortsData.length,
        itemBuilder: (context, index) {
          final data = _shortsData[index];
          final isFocused = index == _focusedIndex;
          
          return _ShortsVideoCard(
            videoUrl: data['url']!,
            creator: data['creator']!,
            description: data['description']!,
            audio: data['audio']!,
            likes: data['likes']!,
            comments: data['comments']!,
            isFocused: isFocused,
          );
        },
      ),
    );
  }
}

class _ShortsVideoCard extends StatefulWidget {
  final String videoUrl;
  final String creator;
  final String description;
  final String audio;
  final String likes;
  final String comments;
  final bool isFocused;

  const _ShortsVideoCard({
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
  State<_ShortsVideoCard> createState() => _ShortsVideoCardState();
}

class _ShortsVideoCardState extends State<_ShortsVideoCard> {
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
  void didUpdateWidget(covariant _ShortsVideoCard oldWidget) {
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
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7)
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

          // Premium sidebar interactive buttons (Likes, comments, shares, audio discs)
          Positioned(
            bottom: 30,
            right: 16,
            child: Column(
              children: [
                _ActionButton(icon: Icons.favorite_rounded, label: widget.likes, iconColor: AppColors.primary),
                const SizedBox(height: 20),
                _ActionButton(icon: Icons.comment_rounded, label: widget.comments),
                const SizedBox(height: 20),
                _ActionButton(icon: Icons.share_rounded, label: 'Share'),
                const SizedBox(height: 20),
                const _SpinningAudioDisc(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.black54,
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _SpinningAudioDisc extends StatefulWidget {
  const _SpinningAudioDisc({Key? key}) : super(key: key);

  @override
  State<_SpinningAudioDisc> createState() => _SpinningAudioDiscState();
}

class _SpinningAudioDiscState extends State<_SpinningAudioDisc> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationController,
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black54,
        child: CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.secondary,
          child: Icon(Icons.music_note_rounded, color: Colors.black87, size: 12),
        ),
      ),
    );
  }
}
