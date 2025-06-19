import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/network/dio_client.dart';
import 'package:dafactory/data/local/prefs_service.dart' show PrefsService;
import 'package:dafactory/data/local/secure_store_service.dart';
import 'package:dafactory/data/mock/mock_repository_impl.dart';
import 'package:dafactory/data/repository_impl/authen_repository_impl.dart';
import 'package:dafactory/data/repository_impl/locale_repository_impl.dart' show LocaleRepositoryImpl;
import 'package:dafactory/data/repository_impl/theme_repository_impl.dart' show ThemeRepositoryImpl;
import 'package:dafactory/domain/repository/auth_repository.dart' show AuthenticationRepository;
import 'package:dafactory/domain/repository/locale_repository.dart' show LocaleRepository;
import 'package:dafactory/domain/repository/theme_repository.dart' show ThemeRepository;
import 'package:get_it/get_it.dart' show GetIt;

import '../../data/services/auth_service.dart' show AuthService;

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final isMock = AppConfig.instance.isMock;
  if (isMock) {
    final mockRepo = MockRepositoryImpl();
    getIt.registerLazySingleton<ThemeRepository>(() => mockRepo);
    getIt.registerLazySingleton<LocaleRepository>(() => mockRepo);
    getIt.registerLazySingleton<AuthenticationRepository>(() => mockRepo);
  } else {
    final prefsService = PrefsService();
    await prefsService.init();
    getIt.registerLazySingleton<AuthService>(() => AuthService(DioClient.instance));
    getIt.registerSingleton<PrefsService>(prefsService);
    getIt.registerSingleton<SecureService>(SecureService());
    getIt.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(getIt<PrefsService>()));
    getIt.registerLazySingleton<LocaleRepository>(() => LocaleRepositoryImpl(getIt<PrefsService>()));
    getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthRepositoryImpl(
        getIt<PrefsService>(),
        getIt<AuthService>(),
        getIt<SecureService>(),
      ),
    );
  }
}
