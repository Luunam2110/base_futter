import 'package:dafactory/data/local/prefs_service.dart' show PrefsService;
import 'package:dafactory/domain/repository/locale_repository.dart' show LocaleRepository;

class LocaleRepositoryImpl implements LocaleRepository {
  final PrefsService _prefs;

  LocaleRepositoryImpl(this._prefs);

  @override
  String loadLocale() {
    return _prefs.getLocate();
  }

  @override
  void saveLocale(String locate) {
    return _prefs.saveLocate(locate);
  }
}