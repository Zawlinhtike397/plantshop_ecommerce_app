import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static const String favouriteKey = "favourite_plants";

  static Future<List<int>> getFavouriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(favouriteKey);

    if (data == null) return [];

    List decoded = jsonDecode(data);
    return decoded.map((e) => e as int).toList();
  }

  static Future<void> saveFavouriteIds(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(favouriteKey, jsonEncode(ids));
  }
}
