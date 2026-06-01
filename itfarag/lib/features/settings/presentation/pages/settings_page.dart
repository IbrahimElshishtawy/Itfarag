// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../../core/injection/service_locator.dart';
import '../../../../core/shared/widgets/glass_card.dart';

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
    // Initialize standard state based on the current state of ThemeManager
    _darkMode = sl<ThemeManager>().isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Theme-dependent colors for unified premium feel
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
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
                GlassCard(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(12),
                  fillOpacity: isDark ? 0.15 : 0.45,
                  borderOpacity: isDark ? 0.2 : 0.1,
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _darkMode,
                        onChanged: (val) {
                          setState(() {
                            _darkMode = val;
                          });
                          // Trigger dynamic theme change globally
                          sl<ThemeManager>().toggleTheme(val);
                        },
                        title: Text(
                          'Ultra Dark Theme Mode', 
                          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Text(
                          'Velvet midnight black interface style', 
                          style: TextStyle(color: subTextColor, fontSize: 11),
                        ),
                        activeColor: AppColors.primary,
                      ),
                      Divider(color: dividerColor, height: 16),
                      SwitchListTile(
                        value: _dataSaver,
                        onChanged: (val) {
                          setState(() {
                            _dataSaver = val;
                          });
                        },
                        title: Text(
                          'Dynamic Data Saver Mode', 
                          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Text(
                          'Limits streams to 480p to reduce internet bills', 
                          style: TextStyle(color: subTextColor, fontSize: 11),
                        ),
                        activeColor: AppColors.secondary,
                      ),
                      Divider(color: dividerColor, height: 16),
                      ListTile(
                        title: Text(
                          'Preferred Content Language', 
                          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Text(
                          'Current language: $_selectedLanguage', 
                          style: TextStyle(color: subTextColor, fontSize: 11),
                        ),
                        trailing: DropdownButton<String>(
                          dropdownColor: isDark ? AppColors.darkBackground : AppColors.lightSurface,
                          value: _selectedLanguage,
                          underline: const SizedBox(),
                          icon: Icon(Icons.arrow_drop_down_rounded, color: textColor),
                          style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold),
                          items: const [
                            DropdownMenuItem(value: 'English', child: Text('English')),
                            DropdownMenuItem(value: 'العربية', child: Text('العربية')),
                            DropdownMenuItem(value: 'Français', child: Text('Français')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedLanguage = val;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                GlassCard(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(16),
                  fillOpacity: isDark ? 0.15 : 0.45,
                  borderOpacity: isDark ? 0.2 : 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Offline Download Speed', 
                        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Downloads will use high-speed multi-threaded chunks decrypting stored visual data on-the-fly.', 
                        style: TextStyle(color: subTextColor, fontSize: 12, height: 1.4),
                      ),
                    ],
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
