import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05)),
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
                  color: isDark ? Colors.white12 : Colors.black12,
                  child: Icon(Icons.movie_creation_outlined, color: isDark ? Colors.white24 : Colors.black26, size: 20),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Cyberpunk Chronicle',
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sci-Fi Thriller • 2026',
                  style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12),
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
