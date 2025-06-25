import 'package:collection/collection.dart';
import 'package:dafactory/app/app_state.dart' show AppState;
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/core/router/router_observer.dart';
import 'package:dafactory/core/utils/screen_size.dart';
import 'package:dafactory/presentation/screens/auth/login/login_screen.dart';
import 'package:dafactory/presentation/screens/common/not_found_screen.dart';
import 'package:dafactory/presentation/screens/main/home/home_screen.dart';
import 'package:dafactory/presentation/screens/main/main/main_screen.dart';
import 'package:dafactory/presentation/screens/main/setting/setting_screen.dart';
import 'package:dafactory/presentation/widgets/button/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => _navigatorKey.currentContext!;

  static const String home = '/home';
  static const String setting = '/setting';
  static const String login = '/login';
  static const String example = '/example';

  static GoRouter createRouter(AppState appState) {
    return GoRouter(
      observers: [
        GoRouterObserver(),
      ],
      navigatorKey: _navigatorKey,
      initialLocation: appState.isLoggedIn ? home : login,
      refreshListenable: appState,
      routes: [
        ..._loginRoutes,
        ..._mainRoutes(appState),
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

  static List<RouteBase> _mainRoutes(AppState appState) {
    return [
      ShellRoute(
        routes: [
          GoRoute(
            path: home,
            pageBuilder: (c, s) {
              return const NoTransitionPage(child: HomeScreen());
            },
          ),
          GoRoute(
            path: setting,
            pageBuilder: (c, s) {
              return const NoTransitionPage(child: SettingScreen());
            },
          ),
          GoRoute(
            path: example,
            pageBuilder: (c, s) {
              final child = Builder(
                builder: (context) {
                  return Scaffold(
                    backgroundColor: context.appColors.background,
                    body: Center(child: SecondaryButton(title: 'back', onPressed: context.pop)),
                  );
                }
              );
              if(!ScreenSize.isDesktop) return MaterialPage(child: child);
              return NoTransitionPage(child: child);
            },
          ),
        ],
        builder: (_, state, child) {
          return MainScreen(child, path: state.uri.path);
        },
      ),
    ];
  }
}
