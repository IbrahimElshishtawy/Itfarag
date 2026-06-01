import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=200&auto=format&fit=crop&q=60',
              width: 80,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 50,
                  color: Colors.white12,
                  child: const Icon(Icons.movie_creation_outlined, color: Colors.white24, size: 20),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Cyberpunk Chronicle',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Sci-Fi Thriller • 2026',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.play_circle_fill_rounded, color: AppColors.primary, size: 28),
        ],
      ),
    );
  }
}
