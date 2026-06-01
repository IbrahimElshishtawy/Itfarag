import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/config/env.dart';
import 'core/config/constants.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/injection/service_locator.dart';

void main() async {
  // Ensure Flutter engine bindings are initialized properly
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Enterprise Multi-flavor Configurations
  Env.init(AppEnvironment.production);

  // Initialize service locator container (GetIt)
  await initServiceLocator();

  // Customize System UI Overlay (Status bar style & orientation settings)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Lock device orientation to portrait by default for mobile flow integrity
  // (Fullscreen toggling handles orientation dynamically inside player screens)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const EtfaragApp());
}

class EtfaragApp extends StatelessWidget {
  const EtfaragApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // Default to premium Midnight Velvet Dark Theme
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
