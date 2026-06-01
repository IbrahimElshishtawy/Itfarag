import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class DownloadSpeedInfoCard extends StatelessWidget {
  final bool isDark;

  const DownloadSpeedInfoCard({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;

    return GlassCard(
      borderRadius: 20,
      padding: const EdgeInsets.all(16),
      fillOpacity: isDark ? 0.15 : 0.45,
      borderOpacity: isDark ? 0.2 : 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offline Download Speed',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Downloads will use high-speed multi-threaded chunks decrypting stored visual data on-the-fly.',
            style: TextStyle(color: subTextColor, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}
