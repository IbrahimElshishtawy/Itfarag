import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import 'media_item.dart';

class MediaCard extends StatelessWidget {
  final MediaItem item;
  final bool isAISuggestion;
  final VoidCallback onTap;

  const MediaCard({
    Key? key,
    required this.item,
    required this.onTap,
    this.isAISuggestion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final title = isArabic ? item.titleAr : item.title;
    final genre = isArabic ? item.genreAr : item.genre;
    final ratingText = isArabic ? '★ ${item.rating} | $genre' : '★ ${item.rating} | $genre';

    // Generates a mock match percentage for AI recommendations
    final int mockMatch = 95 + (item.title.hashCode % 5);

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
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      item.imageUrl,
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
                        left: isArabic ? null : 8,
                        right: isArabic ? 8 : null,
                        child: GlassCard(
                          borderRadius: 8,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          fillOpacity: 0.25,
                          borderOpacity: 0.15,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.psychology, color: AppColors.secondary, size: 12),
                              const SizedBox(width: 3),
                              Text(
                                '$mockMatch%',
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              ratingText,
              style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
