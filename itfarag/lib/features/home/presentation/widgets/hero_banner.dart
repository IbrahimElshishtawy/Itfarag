// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'hero_banner_overlay.dart';

class HeroBanner extends StatelessWidget {
  final VoidCallback onWatchNow;
  final VoidCallback onMoreInfo;

  const HeroBanner({
    Key? key,
    required this.onWatchNow,
    required this.onMoreInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&auto=format&fit=crop&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF252330), Color(0xFF1D1B26)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.movie_creation_outlined, color: Colors.white24, size: 48),
                  ),
                );
              },
            ),
            HeroBannerOverlay(
              onWatchNow: onWatchNow,
              onMoreInfo: onMoreInfo,
            ),
          ],
        ),
      ),
    );
  }
}
