import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/tier_plan_card.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.getBackgroundGradient(context),
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
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join ETFARAG premium to unlock 4K HDR streams, offline secure downloads, and unlimited interactive Watch Parties.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Tier Cards
                const TierPlanCard(
                  name: 'Premium Monthly',
                  price: 'LE 99 / mo',
                  description: 'Watch on 2 devices simultaneously, HD streaming, complete creator library access.',
                  color: AppColors.secondary,
                ),
                const SizedBox(height: 16),
                const TierPlanCard(
                  name: 'Premium Yearly (Save 30%)',
                  price: 'LE 799 / yr',
                  description: 'Watch on 4 devices simultaneously, full 4K UHD Dolby Atmos, zero ad interruptions.',
                  color: AppColors.primary,
                  isPopular: true,
                ),
                const SizedBox(height: 16),
                const TierPlanCard(
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
