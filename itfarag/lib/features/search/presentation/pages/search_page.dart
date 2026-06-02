import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/mood_suggestion_tag.dart';
import '../widgets/search_result_tile.dart';
import '../widgets/ai_search_response_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

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
                Text(
                  'Smart AI Search',
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
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
                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.secondary),
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                  ),
                  onSubmitted: (val) {
                    if (val.isNotEmpty) {
                      _triggerAISmartMoodSearch(val);
                    }
                  },
                ),
                const SizedBox(height: 24),
                AISearchResponseCard(
                  isSearching: _isSearching,
                  responseText: _aiSearchResponse,
                ),
                Text(
                  'Popular Suggestions',
                  style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    MoodSuggestionTag(
                      label: '"I want something funny"',
                      onTap: () => _triggerAISmartMoodSearch('Something light-hearted and very funny to cheer me up'),
                    ),
                    MoodSuggestionTag(
                      label: '"Action packed sci-fi"',
                      onTap: () => _triggerAISmartMoodSearch('Epic sci-fi action movies with spacecrafts and cool effects'),
                    ),
                    MoodSuggestionTag(
                      label: '"Cozy mystery dramas"',
                      onTap: () => _triggerAISmartMoodSearch('Suspenseful cozy detective mysteries'),
                    ),
                    MoodSuggestionTag(
                      label: '"Heartfelt family movie"',
                      onTap: () => _triggerAISmartMoodSearch('Emotional heartwarming family movies'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const SearchResultTile();
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
