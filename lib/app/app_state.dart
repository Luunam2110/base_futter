import 'dart:ui' show Locale;

import 'package:dafactory/core/router/app_router.dart' show AppRouter;
import 'package:dafactory/domain/usecase/auth/get_auth_status_usecase.dart';
import 'package:dafactory/domain/usecase/locate/load_locale_usecase.dart';
import 'package:dafactory/domain/usecase/theme/save_theme_mode_usecase.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:provider/provider.dart';

import '../domain/usecase/locate/save_locale_usecase.dart' show SaveLocaleUseCase;
import '../domain/usecase/theme/load_theme_mode_usecase.dart' show LoadThemeModeUseCase;

class AppState extends ChangeNotifier {
  AppState() {
    initState();
  }

  static AppState current([BuildContext? context]) {
    final realContext = context ?? AppRouter.context;
    return realContext.read<AppState>();
  }

  final getAuthStatus = GetAuthStatusUseCase();
  final loadLocale = LoadLocaleUseCase();
  final loadTheme = LoadThemeModeUseCase();
  final saveLocale = SaveLocaleUseCase();
  final saveTheme = SaveThemeModeUseCase();

  bool _isLoggedIn = false;
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.system;
  DeviceType _deviceType = DeviceType.mobile;

  bool get isLoggedIn => _isLoggedIn;

  Locale get locale => _locale;

  ThemeMode get themeMode => _themeMode;

  DeviceType get deviceType => _deviceType;

  void initState() {
    _isLoggedIn = getAuthStatus().getOrElse(false);
    _locale = loadLocale();
    _themeMode = loadTheme();
    notifyListeners();
  }

  void setDeviceType(DeviceType deviceType) {
    if(_deviceType == deviceType) return;
    _deviceType = deviceType;
    notifyListeners();
  }

  void changeLocale(Locale newMode) {
    if(_locale == newMode) return;
    _locale = newMode;
    saveLocale(newMode);
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode) {
    if(_themeMode == newMode) return;
    _themeMode = newMode;
    saveTheme(newMode);
    notifyListeners();
  }

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

enum DeviceType {mobile, tablet, desktop}
