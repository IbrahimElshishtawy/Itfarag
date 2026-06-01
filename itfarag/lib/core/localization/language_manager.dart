import 'package:flutter/material.dart';

class LanguageManager extends ValueNotifier<Locale> {
  LanguageManager() : super(const Locale('en')); // Default to English

  void changeLanguage(String languageCode) {
    value = Locale(languageCode);
  }

  String get currentLanguageCode => value.languageCode;

  String get currentLanguageName {
    switch (value.languageCode) {
      case 'ar':
        return 'العربية';
      case 'fr':
        return 'Français';
      case 'en':
      default:
        return 'English';
    }
  }
}
