import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final _key = 'authorization';

  Future<String?> getAuthorization() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_key);
  }

  Future<void> setAuthorization(String? authorization) async {
    final prefs = await SharedPreferences.getInstance();

    if (authorization == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, authorization);
    }
  }
}
