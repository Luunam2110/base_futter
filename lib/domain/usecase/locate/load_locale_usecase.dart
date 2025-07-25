import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/extensions/locate_ext.dart';
import 'package:dafactory/core/result/result.dart' show runCatching;
import 'package:dafactory/domain/repository/locale_repository.dart' show LocaleRepository;
import 'package:flutter/material.dart';

class LoadLocaleUseCase {
  LocaleRepository get _repo => getIt<LocaleRepository>();

  Locale call() => runCatching<String, Locale>(
        _repo.loadLocale,
        (mode) => mode.toLocate(),
      ).getOrElse(const Locale('en'));
}
