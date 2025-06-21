import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart' show runCatching;
import 'package:dafactory/core/extensions/theme_ext.dart' show ThemeModeExt;
import 'package:dafactory/domain/repository/theme_repository.dart' show ThemeRepository;
import 'package:flutter/material.dart';

class LoadThemeModeUseCase {
  ThemeRepository get _repo => getIt<ThemeRepository>();

  ThemeMode call() => runCatching<String, ThemeMode>(
        _repo.loadThemeMode,
        (mode) => mode.toThemeMode(),
      ).getOrElse(ThemeMode.system);
}
