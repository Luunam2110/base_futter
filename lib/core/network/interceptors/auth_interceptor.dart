import 'dart:async';

import 'package:dafactory/app/app_state.dart';
import 'package:dafactory/core/constants/api_constants.dart';
import 'package:dafactory/core/network/dio_client.dart';
import 'package:dafactory/core/result/app_exception.dart';
import 'package:dafactory/domain/usecase/auth/get_refresh_token_usecase.dart';
import 'package:dafactory/domain/usecase/auth/refresh_token_usecase.dart' show RefreshTokenUseCase;
import 'package:dafactory/generated/l10n.dart' show S;
import 'package:dafactory/presentation/widgets/dialog/app_dialog.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final List<Completer<String>> _waitQueue = [];
  bool _isRefreshing = false;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    if (err.response?.statusCode == 401 && requestOptions.path != ApiConstants.refreshToken) {
      final completer = Completer<String>();
      _waitQueue.add(completer);
      if (!_isRefreshing) {
        _isRefreshing = true;
        final refreshToken = GetRefreshTokenUseCaseImpl().getRefreshToken().getOrElse('');
        final newToken =
            refreshToken.isEmpty ? '' : (await RefreshTokenUseCase().refreshToken(refreshToken)).getOrElse('');
        _isRefreshing = false;
        for (final request in _waitQueue) {
          request.complete(newToken);
        }
        _waitQueue.clear();
      }
      final token = await completer.future;
      if (token.isNotEmpty) {
        final response = await _retry(requestOptions, token);
        return handler.resolve(response);
      } else {
        await AppDialog.showErrorDialog(
          title: S.current.session_expired,
          message: S.current.session_expired_message,
        );
        AppState.current().logout();
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isRefreshing) {
      final completer = Completer<String>();
      _waitQueue.add(completer);
      final token = await completer.future;
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: UnAuthenticatedException(),
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }
    return handler.next(options);
  }

  Future<Response> _retry(RequestOptions requestOptions, String newToken) {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
    );

    return DioClient.instance.request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}
