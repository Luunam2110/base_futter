import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/env/prod/product.dart';

import 'main.dart' show mainApp;

Future<void> main() async {
  AppConfig.instance = AppConfig.fromJson({...configProdEnv, 'firebase_config': webFirebaseConfigProd});
  await mainApp();
}
