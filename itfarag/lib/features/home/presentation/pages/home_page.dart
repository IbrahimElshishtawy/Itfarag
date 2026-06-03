import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/hero_banner.dart';
import '../widgets/section.dart';
import '../widgets/continue_watching_card.dart';
import '../widgets/media_card.dart';
import '../widgets/live_channel_card.dart';
import '../widgets/media_item.dart';
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

  // Mock Data lists for dynamic presentation
  final List<MediaItem> _continueWatchingItems = [
    const MediaItem(
      title: 'Interstellar',
      titleAr: 'بين النجوم',
      rating: 4.9,
      genre: 'Sci-Fi',
      genreAr: 'خيال علمي',
      imageUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&q=80',
      progress: 0.75,
    ),
    const MediaItem(
      title: 'Breaking Bad',
      titleAr: 'اختلال ضال',
      rating: 4.9,
      genre: 'Crime',
      genreAr: 'جريمة',
      imageUrl: 'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=400&q=80',
      progress: 0.45,
    ),
    const MediaItem(
      title: 'Demon Slayer',
      titleAr: 'قاتل الشياطين',
      rating: 4.8,
      genre: 'Anime',
      genreAr: 'أنمي',
      imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400&q=80',
      progress: 0.90,
    ),
    const MediaItem(
      title: 'The Dark Knight',
      titleAr: 'فارس الظلام',
      rating: 4.9,
      genre: 'Action',
      genreAr: 'أكشن',
      imageUrl: 'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&q=80',
      progress: 0.20,
    ),
  ];

  final List<MediaItem> _recommendedItems = [
    const MediaItem(
      title: 'Dune: Part Two',
      titleAr: 'كثيب: الجزء الثاني',
      rating: 4.9,
      genre: 'Sci-Fi',
      genreAr: 'خيال علمي',
      imageUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=400&q=80',
    ),
    const MediaItem(
      title: 'Succession',
      titleAr: 'الخلافة',
      rating: 4.8,
      genre: 'Drama',
      genreAr: 'دراما',
      imageUrl: 'https://images.unsplash.com/photo-1507608869274-d3177c8bb4c7?w=400&q=80',
    ),
    const MediaItem(
      title: 'Cyberpunk 2077',
      titleAr: 'سايبر بانك ۲۰۷۷',
      rating: 4.7,
      genre: 'Action',
      genreAr: 'أكشن',
      imageUrl: 'https://images.unsplash.com/photo-1542204172-e7052809f852?w=400&q=80',
    ),
    const MediaItem(
      title: 'Spirited Away',
      titleAr: 'المخطوفة',
      rating: 4.9,
      genre: 'Anime',
      genreAr: 'أنمي',
      imageUrl: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=400&q=80',
    ),
    const MediaItem(
      title: 'Chernobyl',
      titleAr: 'تشيرنوبل',
      rating: 4.9,
      genre: 'History',
      genreAr: 'تاريخي',
      imageUrl: 'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=400&q=80',
    ),
  ];

  final List<MediaItem> _aiSuggestedItems = [
    const MediaItem(
      title: 'Inception',
      titleAr: 'بداية',
      rating: 4.8,
      genre: 'Thriller',
      genreAr: 'غموض وحركة',
      imageUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400&q=80',
    ),
    const MediaItem(
      title: 'Blade Runner 2049',
      titleAr: 'بليد رانر ٢٠٤٩',
      rating: 4.8,
      genre: 'Sci-Fi',
      genreAr: 'خيال علمي',
      imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&q=80',
    ),
    const MediaItem(
      title: 'Attack on Titan',
      titleAr: 'هجوم العمالقة',
      rating: 4.9,
      genre: 'Anime',
      genreAr: 'أنمي',
      imageUrl: 'https://images.unsplash.com/photo-1560169897-fc0cdbdfa4d5?w=400&q=80',
    ),
    const MediaItem(
      title: 'The Godfather',
      titleAr: 'العراب',
      rating: 4.9,
      genre: 'Classic',
      genreAr: 'كلاسيكي',
      imageUrl: 'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=400&q=80',
    ),
    const MediaItem(
      title: 'Avatar: Way of Water',
      titleAr: 'أفاتار: طريق الماء',
      rating: 4.7,
      genre: 'Fantasy',
      genreAr: 'خيال',
      imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&q=80',
    ),
  ];

  final List<LiveChannelItem> _liveChannels = [
    const LiveChannelItem(
      name: 'beIN Sports 1 HD',
      nameAr: 'بي إن سبورتس ١ HD',
      currentProgram: 'La Liga: Real Madrid vs Barcelona',
      currentProgramAr: 'الدوري الإسباني: ريال مدريد ضد برشلونة',
      viewers: '2.4M',
      logoUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=100&q=80',
    ),
    const LiveChannelItem(
      name: 'HBO Live',
      nameAr: 'إتش بي أو مباشر',
      currentProgram: 'House of the Dragon - Season 2',
      currentProgramAr: 'مسلسل آل التنين - الموسم الثاني',
      viewers: '850K',
      logoUrl: 'https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?w=100&q=80',
    ),
    const LiveChannelItem(
      name: 'MBC 2 Live',
      nameAr: 'إم بي سي ٢ بث مباشر',
      currentProgram: 'Inception (2010 Movie)',
      currentProgramAr: 'فيلم بداية / إنسيبشن',
      viewers: '430K',
      logoUrl: 'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=100&q=80',
    ),
    const LiveChannelItem(
      name: 'Nat Geo Live',
      nameAr: 'ناشونال جيوغرافيك مباشر',
      currentProgram: 'Predators of the Wild',
      currentProgramAr: 'الحياة البرية: المفترسون في الغابة',
      viewers: '180K',
      logoUrl: 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=100&q=80',
    ),
    const LiveChannelItem(
      name: 'OSN Movies First',
      nameAr: 'أو إس إن سينما الأولى',
      currentProgram: 'Dune: Part Two (Premiere Live)',
      currentProgramAr: 'العرض الأول: فيلم كثيب الجزء الثاني',
      viewers: '620K',
      logoUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=100&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Simulate API fetch delay for smooth shimmer feedback
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    // Localized Headers
    final String continueWatchingTitle = isArabic ? 'متابعة المشاهدة' : 'Continue Watching';
    final String liveChannelsTitle = isArabic ? 'البث التلفزيوني المباشر' : 'Live TV Channels';
    final String recommendedTitle = isArabic ? 'مقترح لك' : 'Recommended For You';
    final String aiFeedTitle = isArabic ? 'توصيات ذكية مخصصة' : 'AI Spark Feed';

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

            // 1. Continue Watching Section
            SliverToBoxAdapter(
              child: Section(
                title: continueWatchingTitle,
                isLoading: _isLoading,
                height: 145,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _continueWatchingItems.length,
                  itemBuilder: (context, index) {
                    return ContinueWatchingCard(
                      item: _continueWatchingItems[index],
                      onTap: () {
                        context.pushNamed(
                          RouteNames.player, 
                          pathParameters: {'id': '20$index'},
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // 2. Live TV Channels (NEW Section)
            SliverToBoxAdapter(
              child: Section(
                title: liveChannelsTitle,
                isLoading: _isLoading,
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _liveChannels.length,
                  itemBuilder: (context, index) {
                    return LiveChannelCard(
                      channel: _liveChannels[index],
                      onTap: () {
                        context.pushNamed(RouteNames.live);
                      },
                    );
                  },
                ),
              ),
            ),

            // 3. Recommended For You Section
            SliverToBoxAdapter(
              child: Section(
                title: recommendedTitle,
                isLoading: _isLoading,
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _recommendedItems.length,
                  itemBuilder: (context, index) {
                    return MediaCard(
                      item: _recommendedItems[index],
                      onTap: () {
                        context.pushNamed(
                          RouteNames.videoDetails, 
                          pathParameters: {'id': '30$index'},
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // 4. AI Spark Feed Section
            SliverToBoxAdapter(
              child: Section(
                title: aiFeedTitle,
                isLoading: _isLoading,
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _aiSuggestedItems.length,
                  itemBuilder: (context, index) {
                    return MediaCard(
                      item: _aiSuggestedItems[index],
                      isAISuggestion: true,
                      onTap: () {
                        context.pushNamed(
                          RouteNames.videoDetails, 
                          pathParameters: {'id': '40$index'},
                        );
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
