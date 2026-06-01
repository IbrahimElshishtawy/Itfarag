import 'package:get_it/get_it.dart';
import '../theme/theme_manager.dart';
import '../localization/language_manager.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core theme management
  sl.registerSingleton<ThemeManager>(ThemeManager());

  // Core localization management
  sl.registerSingleton<LanguageManager>(LanguageManager());
}

