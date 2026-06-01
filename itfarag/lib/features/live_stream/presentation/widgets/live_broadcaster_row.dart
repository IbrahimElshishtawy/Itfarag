// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LiveBroadcasterRow extends StatelessWidget {
  final String broadcasterName;
  final String broadcastTitle;
  final String avatarUrl;
  final VoidCallback onSubscribe;

  const LiveBroadcasterRow({
    Key? key,
    required this.broadcasterName,
    required this.broadcastTitle,
    required this.avatarUrl,
    required this.onSubscribe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  broadcasterName, 
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  broadcastTitle, 
                  style: TextStyle(color: subTextColor, fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent, 
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.star_rounded, size: 16),
            label: const Text('Subscribe'),
            onPressed: onSubscribe,
          ),
        ],
      ),
    );
  }
}
