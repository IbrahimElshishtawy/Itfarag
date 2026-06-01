// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../shared/widgets/glass_card.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
        child: GlassCard(
          borderRadius: 24,
          padding: EdgeInsets.zero,
          fillOpacity: 0.1,
          borderOpacity: 0.1,
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: AppColors.primary.withOpacity(0.2),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              iconTheme: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const IconThemeData(color: AppColors.primary, size: 24);
                }
                return const IconThemeData(color: Colors.white60, size: 22);
              }),
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _onItemTapped(index, context),
              backgroundColor: Colors.transparent,
              elevation: 0,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search_rounded),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: Icon(Icons.play_circle_outline_rounded),
                  label: 'Shorts',
                ),
                NavigationDestination(
                  icon: Icon(Icons.live_tv_rounded),
                  label: 'Live',
                ),
                NavigationDestination(
                  icon: Icon(Icons.video_library_rounded),
                  label: 'Library',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
