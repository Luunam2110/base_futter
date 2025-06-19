import 'package:dafactory/core/env/app_config.dart';

import 'core/env/dev/develop.dart';
import 'main.dart' show mainApp;

Future<void> main() async {
  AppConfig.instance = AppConfig.fromJson({...configDevEnv, 'firebase_config': webFirebaseConfigDev});
  await mainApp();
}
