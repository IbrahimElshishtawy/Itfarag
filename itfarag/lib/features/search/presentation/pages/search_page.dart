import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _aiSearchResponse = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _triggerAISmartMoodSearch(String prompt) {
    setState(() {
      _searchController.text = prompt;
      _isSearching = true;
      _aiSearchResponse = 'AI Recommendation Engine: Searching for titles matching "$prompt"...';
    });

    // Simulate AI recommendations processing
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isSearching = false;
          _aiSearchResponse = 'AI Match Found! Recommended: "The Comedy Project" (Match Rate: 98%), "Laughter Club" (Match Rate: 94%)';
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Heading
                Text(
                  'Smart AI Search',
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                // Search Input Field
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search by title, genre, or mood...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondary),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.mic_none_rounded, color: Colors.white70),
                      onPressed: () => _triggerAISmartMoodSearch('Action thriller with huge plot twists'),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.secondary),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                  ),
                  onSubmitted: (val) {
                    if (val.isNotEmpty) {
                      _triggerAISmartMoodSearch(val);
                    }
                  },
                ),
                const SizedBox(height: 24),
                // AI suggestions
                if (_aiSearchResponse.isNotEmpty) ...[
                  GlassCard(
                    borderRadius: 16,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.psychology_rounded, color: AppColors.secondary, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'AI Mood Engine Response',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _isSearching
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: AppColors.secondary, strokeWidth: 2),
                                ),
                              )
                            : Text(
                                _aiSearchResponse,
                                style: const TextStyle(color: Colors.white80, fontSize: 13, height: 1.4),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                // Popular Searches
                Text(
                  'Popular Suggestions',
                  style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _MoodSuggestionTag(
                      label: '"I want something funny"',
                      onTap: () => _triggerAISmartMoodSearch('Something light-hearted and very funny to cheer me up'),
                    ),
                    _MoodSuggestionTag(
                      label: '"Action packed sci-fi"',
                      onTap: () => _triggerAISmartMoodSearch('Epic sci-fi action movies with spacecrafts and cool effects'),
                    ),
                    _MoodSuggestionTag(
                      label: '"Cozy mystery dramas"',
                      onTap: () => _triggerAISmartMoodSearch('Suspenseful cozy detective mysteries'),
                    ),
                    _MoodSuggestionTag(
                      label: '"Heartfelt family movie"',
                      onTap: () => _triggerAISmartMoodSearch('Emotional heartwarming family movies'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Results list
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const _SearchResultTile();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodSuggestionTag extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MoodSuggestionTag({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.secondary, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=200&auto=format&fit=crop&q=60',
              width: 80,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'The Cyberpunk Chronicle',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Sci-Fi Thriller • 2026',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.play_circle_fill_rounded, color: AppColors.primary, size: 28),
        ],
      ),
    );
  }
}
