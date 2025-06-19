import 'package:dafactory/core/result/app_exception.dart'
    show
        ApiDataException,
        AppException,
        MaintenanceException,
        NoNetworkException,
        UnAuthenticatedException,
        UnAuthorizedException;
import 'package:dafactory/generated/l10n.dart' show S;
import 'package:dio/dio.dart';

class NetworkHandler {
  static AppException handleError(DioException error) {
    return _handleError(error);
  }

  static AppException _handleError(error) {
    if (error is! DioException) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    if (_isNetWorkError(error)) {
      return NoNetworkException();
    }
    if (error.error is AppException) return error.error as AppException;
    final parsedException = _parseError(error);
    final errorCode = error.response?.statusCode;
    if (errorCode != null && errorCode == 401) return UnAuthenticatedException();
    if (errorCode != null && errorCode == 403) return UnAuthorizedException();
    if (errorCode != null && errorCode ~/ 500 > 0) {
      return MaintenanceException();
    }
    return parsedException;
  }

  static bool _isNetWorkError(DioException error) {
    final errorType = error.type;
    switch (errorType) {
      case DioExceptionType.cancel:
        return true;
      case DioExceptionType.connectionTimeout:
        return true;
      case DioExceptionType.receiveTimeout:
        return true;
      case DioExceptionType.sendTimeout:
        return true;
      case DioExceptionType.badResponse:
        return false;
      default:
        return false;
    }
  }

  static AppException _parseError(DioException error) {
    if (error.response?.data is! Map<String, dynamic>) {
      return AppException(S.current.error, S.current.something_went_wrong);
    } else {
      return ApiDataException.fromJson(error.response?.data);
    }
  }
}
