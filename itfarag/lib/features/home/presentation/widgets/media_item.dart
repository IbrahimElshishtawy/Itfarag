import 'package:flutter/material.dart';

class MediaItem {
  final String title;
  final String titleAr;
  final double rating;
  final String genre;
  final String genreAr;
  final String imageUrl;
  final double progress; // Progress value between 0.0 and 1.0 (for continue watching)

  const MediaItem({
    required this.title,
    required this.titleAr,
    required this.rating,
    required this.genre,
    required this.genreAr,
    required this.imageUrl,
    this.progress = 0.0,
  });
}
