import 'dart:ui' show Locale;

import 'package:dafactory/app/app_usecase.dart' show AppUseCase;
import 'package:dafactory/core/router/app_router.dart' show AppRouter;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  AppState() {
    useCase = AppUseCase();
    initState();
  }

  static AppState current([BuildContext? context]) {
    final realContext = context ?? AppRouter.context;
    return realContext.read<AppState>();
  }

  late final AppUseCase useCase;
  bool _isLoggedIn = false;
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.system;

  bool get isLoggedIn => _isLoggedIn;

  Locale get locale => _locale;

  ThemeMode get themeMode => _themeMode;

  void initState() {
    _isLoggedIn = useCase.getAuthStatus().getOrElse(false);
    _locale = useCase.loadLocale();
    _themeMode = useCase.loadTheme();
    notifyListeners();
  }

  void changeLocale(Locale newMode) {
    _locale = newMode;
    useCase.saveLocale(newMode);
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode) {
    _themeMode = newMode;
    useCase.saveTheme(newMode);
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
