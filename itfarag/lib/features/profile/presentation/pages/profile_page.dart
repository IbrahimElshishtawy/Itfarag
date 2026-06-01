import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: AppColors.premiumGradient,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80'),
                        ),
                      ),
                      // Level Badge Overlay (Diamond Level status)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withOpacity(0.4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Text(
                          '💎 DIAMOND',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Sara El-Sayed',
                    style: AppTypography.heading2.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    'Premium Member since June 2026',
                    style: AppTypography.bodySmall.copyWith(color: Colors.white54),
                  ),
                ),
                const SizedBox(height: 24),
                // Achievement / Stream Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _StatsCard(
                        icon: Icons.local_fire_department_rounded,
                        value: '18 Days',
                        label: 'Watch Streak',
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatsCard(
                        icon: Icons.timer_rounded,
                        value: '142 Hrs',
                        label: 'Stream Time',
                        iconColor: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Account links List
                GlassCard(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _ProfileTile(
                        icon: Icons.card_membership_rounded,
                        title: 'My Premium Subscription',
                        subtitle: 'Yearly Plan • Renews in 300 days',
                        onTap: () {
                          context.pushNamed(RouteNames.subscription);
                        },
                      ),
                      const Divider(color: Colors.white12, height: 16),
                      _ProfileTile(
                        icon: Icons.settings_rounded,
                        title: 'Settings & Privacy',
                        subtitle: 'Quality, Downloads, Subtitles',
                        onTap: () {
                          context.pushNamed(RouteNames.settings);
                        },
                      ),
                      const Divider(color: Colors.white12, height: 16),
                      _ProfileTile(
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

class _StatsCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _StatsCard({
    Key? key,
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white.withOpacity(0.05),
        child: Icon(icon, color: Colors.white70, size: 18),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 14),
      onTap: onTap,
    );
  }
}
