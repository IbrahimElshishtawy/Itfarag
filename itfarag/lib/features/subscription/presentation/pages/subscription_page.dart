// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/premium_button.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.darkBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Choose Your Premium Tier',
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join ETFARAG premium to unlock 4K HDR streams, offline secure downloads, and unlimited interactive Watch Parties.',
                  style: AppTypography.bodySmall.copyWith(color: Colors.white60),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Tier Cards
                const _TierPlanCard(
                  name: 'Premium Monthly',
                  price: 'LE 99 / mo',
                  description: 'Watch on 2 devices simultaneously, HD streaming, complete creator library access.',
                  color: AppColors.secondary,
                ),
                const SizedBox(height: 16),
                const _TierPlanCard(
                  name: 'Premium Yearly (Save 30%)',
                  price: 'LE 799 / yr',
                  description: 'Watch on 4 devices simultaneously, full 4K UHD Dolby Atmos, zero ad interruptions.',
                  color: AppColors.primary,
                  isPopular: true,
                ),
                const SizedBox(height: 16),
                const _TierPlanCard(
                  name: 'Family Network Plan',
                  price: 'LE 149 / mo',
                  description: 'Support up to 6 custom family profiles with kids mode age restrictions enabled.',
                  color: AppColors.accent,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TierPlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final Color color;
  final bool isPopular;

  const _TierPlanCard({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.color,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isPopular
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color, width: 2.5),
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.15), blurRadius: 20, spreadRadius: 2),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: AppTypography.heading3.copyWith(color: Colors.white),
                ),
                if (isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('POPULAR', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: AppTypography.heading1.copyWith(color: color, fontSize: 28),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: AppTypography.bodySmall.copyWith(color: Colors.white70),
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
