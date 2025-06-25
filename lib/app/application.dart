import 'package:dafactory/app/app_state.dart' show AppState;
import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/router/app_router.dart';
import 'package:dafactory/core/themes/app_theme.dart' show AppThemes;
import 'package:dafactory/core/utils/screen_size.dart';
import 'package:dafactory/generated/l10n.dart' show S;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart' show KeyboardDismisser;
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:toastification/toastification.dart' show ToastificationWrapper;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appState = AppState();

  late final router = AppRouter.createRouter(appState);

  @override
  Widget build(context) {
    appState.setDeviceType(ScreenSize.init(context));
    return ChangeNotifierProvider(
      create: (_) => appState,
      child: ListenableBuilder(
        listenable: appState,
        builder: (_, __) {
          return KeyboardDismisser(
            child: ToastificationWrapper(
              child: MaterialApp.router(
                routerConfig: router,
                title: AppConfig.instance.appName,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                locale: appState.locale,
                themeMode: appState.themeMode,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
              ),
            ),
          );
        },
      ),
    );
  }
}
