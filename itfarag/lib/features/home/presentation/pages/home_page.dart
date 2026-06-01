// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/hero_banner.dart';
import '../widgets/category_chip.dart';
import '../widgets/section.dart';
import '../widgets/continue_watching_card.dart';
import '../widgets/media_card.dart';
import '../widgets/hero_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate real premium backend fetch API lag
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

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
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // SliverAppBar with logo and notifications
            SliverAppBar(
              floating: true,
              pinned: false,
              backgroundColor: AppColors.darkBackground.withOpacity(0.8),
              title: Text(
                'ETFARAG',
                style: AppTypography.heading2.copyWith(
                  fontSize: 24,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: AppColors.premiumGradient,
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 150.0, 40.0)),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.cast_connected_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            // Hero Banner
            SliverToBoxAdapter(
              child: _isLoading 
                  ? const HeroShimmer() 
                  : HeroBanner(
                      onWatchNow: () {
                        context.pushNamed(
                          RouteNames.player,
                          pathParameters: {'id': '101'},
                        );
                      },
                      onMoreInfo: () {
                        context.pushNamed(
                          RouteNames.videoDetails,
                          pathParameters: {'id': '101'},
                        );
                      },
                    ),
            ),
            // Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      CategoryChip(label: 'All Content', isSelected: true),
                      CategoryChip(label: 'Movies', isSelected: false),
                      CategoryChip(label: 'Series', isSelected: false),
                      CategoryChip(label: 'Anime', isSelected: false),
                      CategoryChip(label: 'Shorts & Reels', isSelected: false),
                      CategoryChip(label: 'Creator Hub', isSelected: false),
                    ],
                  ),
                ),
              ),
            ),
            // Continues Watching Section
            SliverToBoxAdapter(
              child: Section(
                title: 'Continue Watching',
                isLoading: _isLoading,
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ContinueWatchingCard(
                      index: index,
                      onTap: () {
                        context.pushNamed(RouteNames.player, pathParameters: {'id': '20$index'});
                      },
                    );
                  },
                ),
              ),
            ),
            // Recommended For You Section
            SliverToBoxAdapter(
              child: Section(
                title: 'Recommended For You',
                isLoading: _isLoading,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return MediaCard(
                      index: index,
                      onTap: () {
                        context.pushNamed(RouteNames.videoDetails, pathParameters: {'id': '30$index'});
                      },
                    );
                  },
                ),
              ),
            ),
            // AI Personal Smart Feed Section
            SliverToBoxAdapter(
              child: Section(
                title: 'AI Spark Feed (Customized For You)',
                isLoading: _isLoading,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return MediaCard(
                      index: index + 5,
                      isAISuggestion: true,
                      onTap: () {
                        context.pushNamed(RouteNames.videoDetails, pathParameters: {'id': '30$index'});
                      },
                    );
                  },
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
    );
  }
}
