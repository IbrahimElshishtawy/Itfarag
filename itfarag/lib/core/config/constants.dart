class AppConstants {
  static const String appName = 'ETFARAG';
  static const String appSlogan = 'The Future of Entertainment Streaming';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String otpVerifyEndpoint = '/auth/otp/verify';
  static const String logoutEndpoint = '/auth/logout';
  static const String videosEndpoint = '/videos';
  static const String aiMoodSearchEndpoint = '/ai/mood-search';
  static const String playHistoryEndpoint = '/watch-history';
  static const String subscriptionEndpoint = '/subscription';

  // Secure Storage Keys
  static const String tokenKey = 'secure_jwt_access_token';
  static const String refreshTokenKey = 'secure_jwt_refresh_token';
  static const String userProfileKey = 'secure_user_profile_data';
  static const String userSettingsKey = 'app_local_settings';

  // Cache & Prefs
  static const int cacheMaxAgeDays = 7;
  static const int maxLocalCacheSizeBytes = 500 * 1024 * 1024; // 500 MB

  // Animation Durations
  static const int splashDurationMs = 2500;
  static const int transitionDurationMs = 300;
  static const int skeletonShimmerDurationMs = 1500;

  // Watch Party Limits
  static const int maxWatchPartyParticipants = 8;
  static const int syncIntervalMs = 5000;
}
