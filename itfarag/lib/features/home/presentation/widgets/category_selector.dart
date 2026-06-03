import 'package:flutter/material.dart';
import 'category_chip.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final List<String> labels = isArabic
        ? ['كل المحتوى', 'الأفلام', 'المسلسلات', 'الأنمي', 'فيديوهات قصيرة', 'صناع المحتوى']
        : ['All Content', 'Movies', 'Series', 'Anime', 'Shorts & Reels', 'Creator Hub'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: labels.length,
          itemBuilder: (context, index) {
            return CategoryChip(
              label: labels[index],
              isSelected: _selectedIndex == index,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
