import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ShortsDescriptionPanel extends StatelessWidget {
  final String creator;
  final String description;
  final String audio;

  const ShortsDescriptionPanel({
    Key? key,
    required this.creator,
    required this.description,
    required this.audio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 16,
      right: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=60'),
              ),
              const SizedBox(width: 8),
              Text(
                creator,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('Follow', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.music_note_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  audio,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
