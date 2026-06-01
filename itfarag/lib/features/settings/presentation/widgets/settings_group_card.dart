import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class SettingsGroupCard extends StatelessWidget {
  final bool isDark;
  final bool darkMode;
  final bool dataSaver;
  final String selectedLanguage;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onDataSaverChanged;
  final ValueChanged<String?> onLanguageChanged;

  const SettingsGroupCard({
    Key? key,
    required this.isDark,
    required this.darkMode,
    required this.dataSaver,
    required this.selectedLanguage,
    required this.onDarkModeChanged,
    required this.onDataSaverChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;

    return GlassCard(
      borderRadius: 20,
      padding: const EdgeInsets.all(12),
      fillOpacity: isDark ? 0.15 : 0.45,
      borderOpacity: isDark ? 0.2 : 0.1,
      child: Column(
        children: [
          SwitchListTile(
            value: darkMode,
            onChanged: onDarkModeChanged,
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
            value: dataSaver,
            onChanged: onDataSaverChanged,
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
              'Current language: $selectedLanguage',
              style: TextStyle(color: subTextColor, fontSize: 11),
            ),
            trailing: DropdownButton<String>(
              dropdownColor: isDark ? AppColors.darkBackground : AppColors.lightSurface,
              value: selectedLanguage,
              underline: const SizedBox(),
              icon: Icon(Icons.arrow_drop_down_rounded, color: textColor),
              style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold),
              items: const [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'العربية', child: Text('العربية')),
                DropdownMenuItem(value: 'Français', child: Text('Français')),
              ],
              onChanged: onLanguageChanged,
            ),
          ),
        ],
      ),
    );
  }
}
