class AppEnv {
  const AppEnv._();

  static const String rawgApiKey = String.fromEnvironment('RAWG_API_KEY');

  static bool get hasRawgApiKey => rawgApiKey.trim().isNotEmpty;
}
