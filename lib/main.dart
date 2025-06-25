import 'dart:async';
import 'package:dafactory/app/application.dart';
import 'package:dafactory/core/di/module.dart' show configureDependencies;
import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/firebase/notification_fcm.dart';
import 'package:dafactory/core/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/base_bloc/bloc_observer.dart';

Future<void> mainApp() async {
  await runZonedGuarded(
    () async {
      final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
      await Firebase.initializeApp(options: kIsWeb ? AppConfig.instance.firebaseConfig.option : null);
      AppLogger.logger('Start initialization app');
      FlutterError.onError = (e) {
        if (!kIsWeb) FirebaseCrashlytics.instance.recordFlutterFatalError(e);
      };
      setPathUrlStrategy();
      await configureDependencies();
      Bloc.observer = MyBlocObserver();
      await NotificationsManager.instance.initialize();
      FlutterNativeSplash.remove();
      AppLogger.logger('End initialization app');
      runApp(const MyApp());
    },
    (e, s) {
      if (!kIsWeb) FirebaseCrashlytics.instance.recordError(e, s);
    },
  );
}
