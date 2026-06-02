import 'package:flutter/material.dart';
import 'category_chip.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
