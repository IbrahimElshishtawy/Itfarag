// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../shared/widgets/glass_card.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/shorts')) return 2;
    if (location.startsWith('/live')) return 3;
    if (location.startsWith('/favorites')) return 4;
    if (location.startsWith('/profile')) return 5;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/shorts');
        break;
      case 3:
        context.go('/live');
        break;
      case 4:
        context.go('/favorites');
        break;
      case 5:
        context.go('/profile');
        break;
    }
  }

  Widget _buildNavItem(int index, IconData icon, int selectedIndex, BuildContext context) {
    final isSelected = index == selectedIndex;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _onItemTapped(index, context),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected 
              ? AppColors.primary.withOpacity(0.18) 
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 22,
          color: isSelected 
              ? AppColors.primary 
              : (isDark ? Colors.white70 : Colors.black54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
        child: GlassCard(
          borderRadius: 24, // Beautiful premium smooth curves
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          fillOpacity: isDark ? 0.08 : 0.45,
          borderOpacity: isDark ? 0.15 : 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_filled, selectedIndex, context),
              _buildNavItem(1, Icons.search_rounded, selectedIndex, context),
              _buildNavItem(2, Icons.play_circle_outline_rounded, selectedIndex, context),
              _buildNavItem(3, Icons.live_tv_rounded, selectedIndex, context),
              _buildNavItem(4, Icons.video_library_rounded, selectedIndex, context),
              _buildNavItem(5, Icons.person_rounded, selectedIndex, context),
            ],
          ),
        ),
      ),
    );
  }
}
