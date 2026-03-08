import '../config/app_env.dart';

class RawgConfig {
  const RawgConfig._();

  static const String baseUrl = 'https://api.rawg.io/api';
  static String get apiKey => AppEnv.rawgApiKey;
}
