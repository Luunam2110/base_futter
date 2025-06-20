import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart' show Result, runCatching;
import 'package:dafactory/domain/repository/theme_repository.dart' show ThemeRepository;
import 'package:flutter/material.dart' show ThemeMode;

class SaveThemeModeUseCase {
  ThemeRepository get _repo => getIt<ThemeRepository>();

  Result<void> call(ThemeMode mode) => runCatching(() => _repo.saveThemeMode(mode.name), (_) {});
}
