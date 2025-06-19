import 'package:dafactory/data/local/prefs_service.dart' show PrefsService;
import 'package:dafactory/domain/repository/theme_repository.dart' show ThemeRepository;

class ThemeRepositoryImpl implements ThemeRepository {
  final PrefsService _prefs;

  ThemeRepositoryImpl(this._prefs);

  @override
  String loadThemeMode() {
    return _prefs.getThemeMode();
  }

  @override
  void saveThemeMode(String mode) {
    return _prefs.saveThemeMode(mode);
  }
}