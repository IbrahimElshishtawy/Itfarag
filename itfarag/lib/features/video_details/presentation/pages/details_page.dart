// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/cast_list_item.dart';
import '../widgets/video_specs_row.dart';
import '../widgets/video_action_row.dart';
import '../widgets/video_description_section.dart';

class DetailsPage extends StatelessWidget {
  final String id;

  const DetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.getBackgroundGradient(context),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
              backgroundColor: Theme.of(context).colorScheme.surface,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&auto=format&fit=crop&q=80',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VideoSpecsRow(rating: '4.9'),
                    const SizedBox(height: 16),
                    Text(
                      'The Cyber Edge (ID: $id)',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 12),
                    VideoActionRow(
                      onPlayPressed: () {
                        context.pushNamed(
                          RouteNames.player,
                          pathParameters: {'id': id},
                        );
                      },
                      onDownloadPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    const VideoDescriptionSection(
                      description: 'In a dystopian cyberpunk metropolitan future, an rogue virtual agent breaks through the system mainframe, threatening the boundary between physical flesh and code matrices. A team of system hackers must hunt her down before the network collapse.',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Featured Cast',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const CastListItem(
                            actorName: 'Actor Name',
                            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=60',
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
