import 'dart:ui' show Locale;

import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart' show Result, runCatching;
import 'package:dafactory/domain/repository/locale_repository.dart' show LocaleRepository;

class SaveLocaleUseCase {
  LocaleRepository get _repo => getIt<LocaleRepository>();

  Result<void> call(Locale locale) => runCatching(() => _repo.saveLocale(locale.toString()), (_) {});
}