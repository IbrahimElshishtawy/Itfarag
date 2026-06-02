import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MoodSuggestionTag extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const MoodSuggestionTag({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.secondary, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
