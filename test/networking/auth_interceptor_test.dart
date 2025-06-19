import 'package:dafactory/core/di/module.dart';
import 'package:dafactory/core/env/app_config.dart' show AppConfig;
import 'package:dafactory/core/env/dev/develop.dart' show configDevEnv;
import 'package:dafactory/core/network/dio_client.dart' show DioClient;
import 'package:dafactory/domain/repository/auth_repository.dart';
import 'package:dafactory/domain/repository/locale_repository.dart';
import 'package:dio/dio.dart' show Dio, DioException;
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart' show GenerateNiceMocks, MockSpec;
import 'package:mockito/mockito.dart';

import '../generated/networking/auth_interceptor_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LocaleRepository>(),
  MockSpec<AuthenticationRepository>(),
])
void main() {
  late final Dio dio;
  late final DioAdapter dioAdapter;

  setUpAll(() {
    final localeRepo = MockLocaleRepository();
    final authRepo = MockAuthenticationRepository();
    TestWidgetsFlutterBinding.ensureInitialized();
    AppConfig.instance = AppConfig.fromJson(configDevEnv);
    dio = DioClient.instance;
    dioAdapter = DioAdapter(dio: dio, matcher: const FullHttpRequestMatcher());
    getIt.registerSingleton<LocaleRepository>(localeRepo);
    getIt.registerSingleton<AuthenticationRepository>(authRepo);

    const mockToken = 'token';
    const mockLanguage = 'en';
    when(localeRepo.loadLocale()).thenReturn(mockLanguage);
    when(authRepo.getToken()).thenReturn(mockToken);
    when(authRepo.getRefreshToken()).thenReturn('refresh_token');
    when(authRepo.refreshToken('refresh_token')).thenAnswer(
      (_) => Future.delayed(
        const Duration(seconds: 5),
        () => throw Exception(),
      ),
    );
    dioAdapter.onGet(
      '/test',
      (server) => server.reply(
        401,
        {
          'message': 'Unauthorized',
        },
        delay: const Duration(seconds: 5),
      ),
    );
    dioAdapter.onGet(
      '/test2',
      (server) => server.reply(
        401,
        {'message': 'Unauthorized'},
        delay: const Duration(seconds: 5),
      ),
    );
  });

  test('test refresh token failure', () async {
    expectLater(
      () => dio.get('/test'),
      throwsA(isA<DioException>()),
    );
    await Future.delayed(const Duration(seconds: 6));
    await expectLater(
      () => dio.get('/test2'),
      throwsA(isA<DioException>()),
    );
  });
}
