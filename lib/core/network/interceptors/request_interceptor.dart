import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/domain/usecase/auth/get_access_token_usecase.dart' show GetAccessTokenUseCaseImpl;
import 'package:dafactory/domain/usecase/locate/load_locale_usecase.dart' show LoadLocaleUseCaseImpl;
import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String accessToken = GetAccessTokenUseCaseImpl().getAccessToken().getOrElse('');
    final String langCode = LoadLocaleUseCaseImpl().loadLocale().languageCode;
    options.baseUrl = AppConfig.instance.baseUrl;
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept-Language'] = langCode;
    options.headers['Accept'] = '*/*';
    if (accessToken.isNotEmpty) {
      options.headers.remove('Authorization');
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}
