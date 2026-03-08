import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_saved_game.dart';

class AppStorage {
  const AppStorage._();

  static SharedPreferences? _prefs;
  static const String _libraryKey = 'library_saved_games';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<List<LocalSavedGame>> getSavedGames() async {
    await init();
    final String raw = _prefs!.getString(_libraryKey) ?? '[]';
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;

    return decoded
        .map((dynamic item) => LocalSavedGame.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveGames(List<LocalSavedGame> games) async {
    await init();
    final SharedPreferences prefs = _prefs!;
    final String encoded = jsonEncode(
      games.map((LocalSavedGame game) => game.toJson()).toList(),
    );
    await prefs.setString(_libraryKey, encoded);
  }
}
