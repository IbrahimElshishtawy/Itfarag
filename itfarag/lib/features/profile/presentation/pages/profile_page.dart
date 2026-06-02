// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/profile_tile.dart';
import '../widgets/profile_header_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;

    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const ProfileHeaderCard(
                  userName: 'Sara El-Sayed',
                  joinDate: 'Premium Member since June 2026',
                  levelText: '💎 DIAMOND',
                  avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(
                      child: StatsCard(
                        icon: Icons.local_fire_department_rounded,
                        value: '18 Days',
                        label: 'Watch Streak',
                        iconColor: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        icon: Icons.timer_rounded,
                        value: '142 Hrs',
                        label: 'Stream Time',
                        iconColor: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GlassCard(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ProfileTile(
                        icon: Icons.card_membership_rounded,
                        title: 'My Premium Subscription',
                        subtitle: 'Yearly Plan • Renews in 300 days',
                        onTap: () {
                          context.pushNamed(RouteNames.subscription);
                        },
                      ),
                      Divider(color: dividerColor, height: 16),
                      ProfileTile(
                        icon: Icons.settings_rounded,
                        title: 'Settings & Privacy',
                        subtitle: 'Quality, Downloads, Subtitles',
                        onTap: () {
                          context.pushNamed(RouteNames.settings);
                        },
                      ),
                      Divider(color: dividerColor, height: 16),
                      ProfileTile(
                        icon: Icons.dashboard_customize_rounded,
                        title: 'Creator Analytics Dashboard',
                        subtitle: 'Uploads, Viewers & Followers metrics',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Log Out Account', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    context.goNamed(RouteNames.login);
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
