// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class PlaylistCard extends StatelessWidget {
  final String title;
  final int count;
  final Color gradientStart;

  const PlaylistCard({
    Key? key,
    required this.title,
    required this.count,
    required this.gradientStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: GlassCard(
        borderRadius: 16,
        padding: const EdgeInsets.all(12),
        fillOpacity: 0.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: gradientStart.withOpacity(0.2),
              child: Icon(Icons.playlist_play_rounded, color: gradientStart, size: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$count titles',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
