// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/shorts_video_card.dart';

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
      body: Stack(
        children: [
          PageView.builder(
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
              
              return ShortsVideoCard(
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
          // Premium floating semi-transparent back button
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/home');
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
