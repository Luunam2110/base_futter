import 'package:collection/collection.dart';
import 'package:dafactory/app/app_state.dart' show AppState;
import 'package:dafactory/core/router/router_observer.dart';
import 'package:dafactory/core/utils/screen_size.dart';
import 'package:dafactory/presentation/screens/auth/login/login_screen.dart';
import 'package:dafactory/presentation/screens/common/not_found_screen.dart';
import 'package:dafactory/presentation/screens/main/home/home_screen.dart';
import 'package:dafactory/presentation/screens/main/main_screen.dart';
import 'package:dafactory/presentation/screens/main/navigator/navigator_screen.dart';
import 'package:dafactory/presentation/screens/main/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => _navigatorKey.currentContext!;

  static const String home = '/home';
  static const String setting = '/setting';
  static const String login = '/login';

  static GoRouter createRouter(AppState appState) {
    return GoRouter(
      observers: [
        GoRouterObserver(),
      ],
      navigatorKey: _navigatorKey,
      initialLocation: appState.isLoggedIn ? home : login,
      refreshListenable: appState,
      routes: [
        if (!appState.isLoggedIn) ..._loginRoutes else ..._mainRoutes,
      ],
      redirect: (context, state) {
        final loggingIn =
            _loginRoutes.map((e) => e.path).firstWhereOrNull((p) => state.matchedLocation.contains(p)) != null;
        final isLoggedIn = appState.isLoggedIn;
        if (!isLoggedIn && !loggingIn) {
          return login;
        }
        if (loggingIn && isLoggedIn) {
          return home;
        }
        return null;
      },
      errorBuilder: (_, __) {
        return const NotFoundScreen();
      },
    );
  }

  static final _loginRoutes = <GoRoute>[
    GoRoute(
      path: login,
      builder: (c, s) => const LoginScreen(),
    ),
  ];

  static final _mainRoutes = <RouteBase>[
    ShellRoute(
      redirect: (_, state) {
        if (ScreenSize.isMobile) {
          switch (state.path) {
            case setting:
              return Uri(path: home, queryParameters: {'initPage': 'setting'}).toString();
          }
        }
        return null;
      },
      routes: [
        if (ScreenSize.isMobile) ...[
          GoRoute(
            path: home,
            // contain home and setting
            builder: (c, s) => NavigatorScreen.mobile(),
          ),
        ] else ...[
          GoRoute(
            path: home,
            builder: (c, s) => const HomeScreen(),
          ),
          GoRoute(
            path: setting,
            builder: (c, s) => const SettingScreen(),
          ),
        ]
      ],
      builder: (_, state, child) {
        // Navigation drawer if is desktop and crate bloc provider
        return MainScreen(child);
      },
    ),
  ];
}
