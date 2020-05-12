import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> setUseGeolocation(bool value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool("useGeolocation", value);
  }

  Future<bool> getUseGeolocation() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool("useGeolocation");
  }

  Future<bool> setCustomLocation(String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString("customLocation", value);
  }

  Future<String> getCustomLocation() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("customLocation");
  }
}
