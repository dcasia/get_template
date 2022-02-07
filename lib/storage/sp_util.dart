import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SpUtil {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> remove(String key) => _prefs.remove(key);

  static String? getString(String key) => _prefs.getString(key);

  static Map? getJson(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  static Future<bool> setJson(String key, Map data) =>
      _prefs.setString(key, jsonEncode(data));
}
