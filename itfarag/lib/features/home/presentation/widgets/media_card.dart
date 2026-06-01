// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class MediaCard extends StatelessWidget {
  final int index;
  final bool isAISuggestion;
  final VoidCallback onTap;

  const MediaCard({
    Key? key,
    required this.index,
    required this.onTap,
    this.isAISuggestion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urls = [
      'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&auto=format&fit=crop&q=60',
    ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      urls[index % urls.length],
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
                            child: Icon(Icons.movie_creation_outlined, color: Colors.white24, size: 24),
                          ),
                        );
                      },
                    ),
                    if (isAISuggestion)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: GlassCard(
                          borderRadius: 6,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          fillOpacity: 0.3,
                          child: Row(
                            children: const [
                              Icon(Icons.psychology, color: AppColors.secondary, size: 10),
                              SizedBox(width: 2),
                              Text('98%', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Show/Movie Name',
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            const Text(
              '★ 4.8 | Sci-Fi',
              style: TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
