import 'package:dafactory/app/app_state.dart';
import 'package:dafactory/app/application.dart';
import 'package:dafactory/core/di/module.dart' show configureDependencies;
import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/firebase/notification_fcm.dart';
import 'package:dafactory/core/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await mainApp();
}

Future<void> mainApp() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  setPathUrlStrategy();
  await initializationApp();
  runApp(ChangeNotifierProvider(create: (_) => AppState(), child: const MyApp()));
}

Future<void> initializationApp() async {
  logger.d('Start initialization app');
  await configureDependencies();
  await Firebase.initializeApp(options: kIsWeb ? AppConfig.instance.firebaseConfig.option: null);
  await NotificationsManager.instance.initialize();
  //todo sth
  FlutterNativeSplash.remove();
  logger.d('End initialization app');
}
