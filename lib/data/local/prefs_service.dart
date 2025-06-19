import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _prefThemeMode = 'PREF_THEME_MODE';
  static const _prefLocate = 'PREF_LOCATE';
  static const _prefToken = 'PREF_TOKEN';
  static const _prefRefreshToken = 'PREF_REFRESH_TOKEN';

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void saveThemeMode(String mode) {
    _prefs.setString(_prefThemeMode, mode);
  }

  String getThemeMode() {
    return _prefs.getString(_prefThemeMode) ?? 'system';
  }

  void saveLocate(String locate) {
    _prefs.setString(_prefLocate, locate);
  }

  String getLocate() {
    return _prefs.getString(_prefLocate) ?? 'en';
  }

  void saveAuthInfo({String? token, String? refreshToken}) {
    if (token != null) _prefs.setString(_prefToken, token);
    if (refreshToken != null) _prefs.setString(_prefRefreshToken, refreshToken);
  }

  void clearAuthInfo() {
    _prefs.remove(_prefToken);
    _prefs.remove(_prefRefreshToken);
  }

  String? getAuthToken() {
    return _prefs.getString(_prefToken);
  }

  String? getRefreshToken() {
    return _prefs.getString(_prefRefreshToken);
  }
}
