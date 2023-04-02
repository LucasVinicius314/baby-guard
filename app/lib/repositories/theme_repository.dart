import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  final _key = 'theme';

  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final themeMode = prefs.getString(_key);

    if (themeMode == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.byName(themeMode);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_key, themeMode.name);
  }
}
