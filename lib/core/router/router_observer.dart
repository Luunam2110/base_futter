import 'package:dafactory/core/utils/logger.dart';
import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.logger('didPop: $route', ['ROUTER']);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.logger('didPush: $route', ['ROUTER']);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.logger('didRemove: $route', ['ROUTER']);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    AppLogger.logger('didReplace: $newRoute', ['ROUTER']);
  }
}
