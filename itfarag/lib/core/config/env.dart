enum AppEnvironment {
  development,
  staging,
  production,
}

class EnvConfig {
  final String apiBaseUrl;
  final String webSocketUrl;
  final String streamCdnUrl;
  final String firebaseApiKey;
  final bool enableAnalytics;

  const EnvConfig({
    required this.apiBaseUrl,
    required this.webSocketUrl,
    required this.streamCdnUrl,
    required this.firebaseApiKey,
    required this.enableAnalytics,
  });
}

class Env {
  static late EnvConfig _config;
  static late AppEnvironment _currentEnv;

  static AppEnvironment get current => _currentEnv;
  static EnvConfig get config => _config;

  static void init(AppEnvironment env) {
    _currentEnv = env;
    switch (env) {
      case AppEnvironment.development:
        _config = const EnvConfig(
          apiBaseUrl: 'https://dev.api.itfarag.com/api/v1',
          webSocketUrl: 'wss://dev.api.itfarag.com/ws/v1',
          streamCdnUrl: 'https://dev-cdn.itfarag.com',
          firebaseApiKey: 'AIzaSyDevFakeKey1234567890',
          enableAnalytics: false,
        );
        break;
      case AppEnvironment.staging:
        _config = const EnvConfig(
          apiBaseUrl: 'https://staging.api.itfarag.com/api/v1',
          webSocketUrl: 'wss://staging.api.itfarag.com/ws/v1',
          streamCdnUrl: 'https://staging-cdn.itfarag.com',
          firebaseApiKey: 'AIzaSyStagingFakeKey1234567890',
          enableAnalytics: true,
        );
        break;
      case AppEnvironment.production:
        _config = const EnvConfig(
          apiBaseUrl: 'https://api.itfarag.com/api/v1',
          webSocketUrl: 'wss://api.itfarag.com/ws/v1',
          streamCdnUrl: 'https://cdn.itfarag.com',
          firebaseApiKey: 'AIzaSyProductionRealKey1234567890',
          enableAnalytics: true,
        );
        break;
    }
  }
}
