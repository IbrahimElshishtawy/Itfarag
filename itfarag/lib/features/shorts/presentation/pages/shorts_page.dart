import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({Key? key}) : super(key: key);

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _shortThumbnails = [
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1542204172-e7052809a936?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=800&auto=format&fit=crop&q=80'
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: _shortThumbnails.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Vertical short visual backdrop image
              Image.network(
                _shortThumbnails[index],
                fit: BoxFit.cover,
              ),
              // Dark gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Creator and short details
              Positioned(
                bottom: 100,
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
                        const Text(
                          '@Sara_Creator',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
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
                    const Text(
                      'AI VFX Breakdown: Transforming simple greenscreen clips into beautiful cyberpunk metropolitan skylines! 🦾✨',
                      style: TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.music_note_rounded, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text('Original Audio - Sara_Creator', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              // Action triggers
              Positioned(
                bottom: 100,
                right: 16,
                child: Column(
                  children: [
                    _ActionButton(icon: Icons.favorite_rounded, label: '34K', iconColor: AppColors.primary),
                    const SizedBox(height: 20),
                    _ActionButton(icon: Icons.comment_rounded, label: '1.2K'),
                    const SizedBox(height: 20),
                    _ActionButton(icon: Icons.share_rounded, label: 'Share'),
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.star_purple500_rounded, color: AppColors.secondary),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
