// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/premium_button.dart';
import 'tier_plan_header.dart';

class TierPlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final Color color;
  final bool isPopular;

  const TierPlanCard({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.color,
    this.isPopular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isPopular
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            )
          : null,
      child: GlassCard(
        borderRadius: 24,
        padding: const EdgeInsets.all(24),
        fillOpacity: isPopular ? 0.15 : 0.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TierPlanHeader(
              name: name,
              color: color,
              isPopular: isPopular,
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: AppTypography.heading1.copyWith(
                color: color,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            PremiumButton(
              text: 'Purchase Now',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Initializing secure checkout for: $name'),
                    backgroundColor: color,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
