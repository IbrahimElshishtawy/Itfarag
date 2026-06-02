import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class AISearchResponseCard extends StatelessWidget {
  final bool isSearching;
  final String responseText;

  const AISearchResponseCard({
    super.key,
    required this.isSearching,
    required this.responseText,
  });

  @override
  Widget build(BuildContext context) {
    if (responseText.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GlassCard(
          borderRadius: 16,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.psychology_rounded, color: AppColors.secondary, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'AI Mood Engine Response',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              isSearching
                  ? const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: AppColors.secondary, strokeWidth: 2),
                      ),
                    )
                  : Text(
                      responseText,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
