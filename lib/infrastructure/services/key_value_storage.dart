import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getValue(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.getString(key);
  }

  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  Future<void> setValueKey<T>(String key, String value) async {
    final prefs = await getSharedPrefs();
    await prefs.setString(key, value);
  }
}
