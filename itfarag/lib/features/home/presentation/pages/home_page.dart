// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/hero_banner.dart';
import '../widgets/section.dart';
import '../widgets/continue_watching_card.dart';
import '../widgets/media_card.dart';
import '../widgets/hero_shimmer.dart';
import '../widgets/home_sliver_app_bar.dart';
import '../widgets/category_selector.dart';

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
            const HomeSliverAppBar(),
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
            const SliverToBoxAdapter(
              child: CategorySelector(),
            ),
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
