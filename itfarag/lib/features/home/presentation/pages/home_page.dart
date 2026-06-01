import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/shimmer_loader.dart';

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
              child: _isLoading ? const _HeroShimmer() : const _HeroBanner(),
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
                      _CategoryChip(label: 'All Content', isSelected: true),
                      _CategoryChip(label: 'Movies', isSelected: false),
                      _CategoryChip(label: 'Series', isSelected: false),
                      _CategoryChip(label: 'Anime', isSelected: false),
                      _CategoryChip(label: 'Shorts & Reels', isSelected: false),
                      _CategoryChip(label: 'Creator Hub', isSelected: false),
                    ],
                  ),
                ),
              ),
            ),
            // Continues Watching Section
            SliverToBoxAdapter(
              child: _Section(
                title: 'Continue Watching',
                isLoading: _isLoading,
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _ContinueWatchingCard(index: index);
                  },
                ),
              ),
            ),
            // Recommended For You Section
            SliverToBoxAdapter(
              child: _Section(
                title: 'Recommended For You',
                isLoading: _isLoading,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _MediaCard(index: index);
                  },
                ),
              ),
            ),
            // AI Personal Smart Feed Section
            SliverToBoxAdapter(
              child: _Section(
                title: 'AI Spark Feed (Customized For You)',
                isLoading: _isLoading,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _MediaCard(index: index + 5, isAISuggestion: true);
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

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&auto=format&fit=crop&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('TRENDING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.stars_rounded, color: AppColors.secondary, size: 16),
                const SizedBox(width: 4),
                const Text('AI Best Choice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'The Cyber Edge',
              style: AppTypography.heading1.copyWith(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              'Action • Sci-Fi • Post-Apocalyptic',
              style: AppTypography.bodySmall.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Watch Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      context.pushNamed(
                        RouteNames.player,
                        pathParameters: {'id': '101'},
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.info_outline_rounded),
                    label: const Text('More Info'),
                    onPressed: () {
                      context.pushNamed(
                        RouteNames.videoDetails,
                        pathParameters: {'id': '101'},
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CategoryChip({
    Key? key,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {},
        backgroundColor: Colors.white.withOpacity(0.05),
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.white60,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final bool isLoading;
  final double height;
  final Widget child;

  const _Section({
    Key? key,
    required this.title,
    required this.isLoading,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 24, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.heading3.copyWith(color: Colors.white),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white54),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: height,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ShimmerLoader(
                      width: height * 0.8,
                      height: height,
                      borderRadius: 16,
                    ),
                  ),
                )
              : child,
        ),
      ],
    );
  }
}

class _ContinueWatchingCard extends StatelessWidget {
  final int index;

  const _ContinueWatchingCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=400&auto=format&fit=crop&q=60'
    ];

    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.player, pathParameters: {'id': '20$index'});
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(images[index % images.length]),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            const Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black54,
                child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 14),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Movie title', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: const LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 3,
                      ),
                    ),
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

class _MediaCard extends StatelessWidget {
  final int index;
  final bool isAISuggestion;

  const _MediaCard({
    Key? key,
    required this.index,
    this.isAISuggestion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urls = [
      'https://images.unsplash.com/photo-1542204172-e7052809a936?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400&auto=format&fit=crop&q=60',
      'https://images.unsplash.com/photo-1497124401559-3e75ec2e794a?w=400&auto=format&fit=crop&q=60',
    ];

    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.videoDetails, pathParameters: {'id': '30$index'});
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      urls[index % urls.length],
                      fit: BoxFit.cover,
                    ),
                    if (isAISuggestion)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: GlassCard(
                          borderRadius: 6,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          fillOpacity: 0.3,
                          child: Row(
                            children: const [
                              Icon(Icons.psychology, color: AppColors.secondary, size: 10),
                              SizedBox(width: 2),
                              Text('98%', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Show/Movie Name',
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            const Text(
              '★ 4.8 | Sci-Fi',
              style: TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroShimmer extends StatelessWidget {
  const _HeroShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ShimmerLoader(
        width: double.infinity,
        height: 380,
        borderRadius: 24,
      ),
    );
  }
}
