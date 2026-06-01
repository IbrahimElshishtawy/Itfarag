import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import 'main_layout.dart';

// Feature Pages Imports
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/shorts/presentation/pages/shorts_page.dart';
import '../../features/live_stream/presentation/pages/live_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/video_details/presentation/pages/details_page.dart';
import '../../features/player/presentation/pages/player_page.dart';
import '../../features/subscription/presentation/pages/subscription_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    // Splash Route
    GoRoute(
      path: '/splash',
      name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    // Onboarding Route
    GoRoute(
      path: '/onboarding',
      name: RouteNames.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    // Auth Routes
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/otp/:phone',
      name: RouteNames.otp,
      builder: (context, state) {
        final phone = state.pathParameters['phone'] ?? '';
        return OtpPage(phone: phone);
      },
    ),
    // Core Streaming Shell Routes
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/search',
          name: RouteNames.search,
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/shorts',
          name: RouteNames.shorts,
          builder: (context, state) => const ShortsPage(),
        ),
        GoRoute(
          path: '/live',
          name: RouteNames.live,
          builder: (context, state) => const LivePage(),
        ),
        GoRoute(
          path: '/favorites',
          name: RouteNames.favorites,
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    // Standalone Fullscreen / Sub Routes
    GoRoute(
      path: '/video_details/:id',
      name: RouteNames.videoDetails,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return DetailsPage(id: id);
      },
    ),
    GoRoute(
      path: '/player/:id',
      name: RouteNames.player,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return PlayerPage(id: id);
      },
    ),
    GoRoute(
      path: '/subscription',
      name: RouteNames.subscription,
      builder: (context, state) => const SubscriptionPage(),
    ),
    GoRoute(
      path: '/settings',
      name: RouteNames.settings,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
