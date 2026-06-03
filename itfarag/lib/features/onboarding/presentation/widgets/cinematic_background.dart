// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class CinematicBackground extends StatelessWidget {
  const CinematicBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // A curated selection of high-quality cinema/movie related images
    final List<String> column1Images = [
      'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=300&q=80', // Theater seats
      'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=300&q=80', // Projector
      'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=300&q=80', // Neon Cinema sign
      'https://images.unsplash.com/photo-1542204172-e7052809f852?w=300&q=80', // Dramatic movie scene
    ];

    final List<String> column2Images = [
      'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=300&q=80', // Clapperboard
      'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=300&q=80', // Film roll
      'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?w=300&q=80', // Cinema stage
      'https://images.unsplash.com/photo-1574267432553-4b4628081c31?w=300&q=80', // Popcorn & screen
    ];

    final List<String> column3Images = [
      'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=300&q=80', // Studio lighting
      'https://images.unsplash.com/photo-1507608869274-d3177c8bb4c7?w=300&q=80', // Cinematic sunset sky
      'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=300&q=80', // Film camera
      'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=300&q=80', // Red curtains
    ];

    return Stack(
      children: [
        // 1. Moving Collage of Images
        Positioned.fill(
          child: Opacity(
            opacity: isDark ? 0.35 : 0.45,
            child: Row(
              children: [
                Expanded(
                  child: _MovingColumn(
                    imageUrls: column1Images,
                    reverse: false,
                    durationSeconds: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MovingColumn(
                    imageUrls: column2Images,
                    reverse: true,
                    durationSeconds: 38,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MovingColumn(
                    imageUrls: column3Images,
                    reverse: false,
                    durationSeconds: 35,
                  ),
                ),
              ],
            ),
          ),
        ),

        // 2. Premium Cinematic Gradients overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        const Color(0xFF09080C).withOpacity(0.85),
                        const Color(0xFF09080C).withOpacity(0.5),
                        const Color(0xFF09080C).withOpacity(0.95),
                      ]
                    : [
                        const Color(0xFFF4F5FA).withOpacity(0.8),
                        const Color(0xFFF4F5FA).withOpacity(0.4),
                        const Color(0xFFF4F5FA).withOpacity(0.9),
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // 3. Radial center glow for extra drama
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  isDark ? const Color(0xFF09080C) : const Color(0xFFF4F5FA),
                ],
                radius: 1.2,
              ),
            ),
          ),
        ),

        // 4. Glassmorphism Blur Filter
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

class _MovingColumn extends StatefulWidget {
  final List<String> imageUrls;
  final bool reverse;
  final int durationSeconds;

  const _MovingColumn({
    required this.imageUrls,
    required this.reverse,
    required this.durationSeconds,
  });

  @override
  State<_MovingColumn> createState() => _MovingColumnState();
}

class _MovingColumnState extends State<_MovingColumn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemHeight = constraints.maxWidth * 1.5; // Aspect ratio 2:3
        final double totalHeight = itemHeight * widget.imageUrls.length;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Translate the column based on controller progress
            double translation = _controller.value * totalHeight;
            if (widget.reverse) {
              translation = -translation;
            }

            return Stack(
              children: [
                Positioned(
                  top: translation,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Double the list to ensure seamless infinite looping
                      ..._buildImageList(itemHeight),
                      ..._buildImageList(itemHeight),
                      ..._buildImageList(itemHeight),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildImageList(double itemHeight) {
    return widget.imageUrls.map((url) {
      return Container(
        height: itemHeight,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey.withOpacity(0.1),
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation(Colors.grey),
                    ),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.withOpacity(0.1),
                child: const Icon(Icons.movie_outlined, color: Colors.grey),
              );
            },
          ),
        ),
      );
    }).toList();
  }
}
