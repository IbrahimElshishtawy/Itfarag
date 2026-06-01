import 'package:get_it/get_it.dart';
import '../theme/theme_manager.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core theme management
  sl.registerSingleton<ThemeManager>(ThemeManager());

  // Service locator initialization stub for Clean Architecture.
  // Here we would normally register:
  // - External dependencies (Dio, Secure Storage, InternetConnectionChecker)
  // - Data sources (Local/Remote for all 13 modules)
  // - Repositories implementations
  // - Use Cases
  // - BLoC Factory registrations
}

