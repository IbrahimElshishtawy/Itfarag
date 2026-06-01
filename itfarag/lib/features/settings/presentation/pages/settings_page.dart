// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../../core/localization/language_manager.dart';
import '../../../../core/injection/service_locator.dart';
import '../widgets/settings_group_card.dart';
import '../widgets/download_speed_info_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _darkMode;
  bool _dataSaver = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _darkMode = sl<ThemeManager>().isDarkMode;
    _selectedLanguage = sl<LanguageManager>().currentLanguageName;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appBarColor = isDark ? Colors.white : Colors.black87;
    
    final bgGradient = isDark 
        ? AppColors.darkBackgroundGradient 
        : [const Color(0xFFF2F3F8), const Color(0xFFE3E5EE)];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Settings', 
          style: TextStyle(color: appBarColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: appBarColor),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgGradient,
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
                SettingsGroupCard(
                  isDark: isDark,
                  darkMode: _darkMode,
                  dataSaver: _dataSaver,
                  selectedLanguage: _selectedLanguage,
                  onDarkModeChanged: (val) {
                    setState(() {
                      _darkMode = val;
                    });
                    sl<ThemeManager>().toggleTheme(val);
                  },
                  onDataSaverChanged: (val) {
                    setState(() {
                      _dataSaver = val;
                    });
                  },
                  onLanguageChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedLanguage = val;
                      });
                      String code = 'en';
                      if (val == 'العربية') code = 'ar';
                      if (val == 'Français') code = 'fr';
                      sl<LanguageManager>().changeLanguage(code);
                    }
                  },
                ),
                const SizedBox(height: 24),
                DownloadSpeedInfoCard(isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
