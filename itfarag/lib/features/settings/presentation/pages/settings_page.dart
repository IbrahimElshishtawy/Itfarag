import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;
  bool _dataSaver = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
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
                GlassCard(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _darkMode,
                        onChanged: (val) {
                          setState(() {
                            _darkMode = val;
                          });
                        },
                        title: const Text('Ultra Dark Theme Mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        subtitle: const Text('Velvet midnight black interface style', style: TextStyle(color: Colors.white54, fontSize: 11)),
                        activeColor: AppColors.primary,
                      ),
                      const Divider(color: Colors.white12, height: 16),
                      SwitchListTile(
                        value: _dataSaver,
                        onChanged: (val) {
                          setState(() {
                            _dataSaver = val;
                          });
                        },
                        title: const Text('Dynamic Data Saver Mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        subtitle: const Text('Limits streams to 480p to reduce internet bills', style: TextStyle(color: Colors.white54, fontSize: 11)),
                        activeColor: AppColors.secondary,
                      ),
                      const Divider(color: Colors.white12, height: 16),
                      ListTile(
                        title: const Text('Preferred Content Language', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        subtitle: Text('Current language: $_selectedLanguage', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                        trailing: DropdownButton<String>(
                          dropdownColor: AppColors.darkBackground,
                          value: _selectedLanguage,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Offline Download Speed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 8),
                      Text('Downloads will use high-speed multi-threaded chunks decrypting stored visual data on-the-fly.', style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.4)),
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
