import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/playlist_card.dart';
import '../widgets/library_item_tile.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.darkBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Heading
                Text(
                  'My Library & Saved',
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
                // Custom Playlists Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Custom Playlists', style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 18)),
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16, color: AppColors.secondary),
                      label: const Text('New List', style: TextStyle(color: AppColors.secondary)),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      PlaylistCard(title: 'Sci-Fi Binge', count: 12, gradientStart: AppColors.primary),
                      PlaylistCard(title: 'Late Night Chill', count: 6, gradientStart: AppColors.accent),
                      PlaylistCard(title: 'Educational Docs', count: 22, gradientStart: AppColors.secondary),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Watch Later list
                Text('Watch Later', style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return LibraryItemTile(
                        onDelete: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
