import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';

class VideoDescriptionSection extends StatelessWidget {
  final String description;

  const VideoDescriptionSection({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(color: Colors.white70, height: 1.4, fontSize: 13),
        ),
      ],
    );
  }
}
