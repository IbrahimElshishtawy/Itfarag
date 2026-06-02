import 'package:flutter/material.dart';

class VideoDescriptionSection extends StatelessWidget {
  final String description;

  const VideoDescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87, height: 1.4, fontSize: 13),
        ),
      ],
    );
  }
}
