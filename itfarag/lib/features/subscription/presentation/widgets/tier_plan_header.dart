import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';

class TierPlanHeader extends StatelessWidget {
  final String name;
  final Color color;
  final bool isPopular;

  const TierPlanHeader({
    super.key,
    required this.name,
    required this.color,
    required this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (isPopular)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'POPULAR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
