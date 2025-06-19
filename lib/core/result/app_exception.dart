import 'package:dafactory/generated/l10n.dart';

class AppException implements Exception {
  final String title;
  final String message;

  const AppException(this.title, this.message);

  @override
  String toString() => '$title $message';
}

class CommonException extends AppException {
  CommonException() : super(S.current.error, S.current.something_went_wrong);
}

class NoNetworkException extends AppException {
  NoNetworkException() : super(S.current.error, S.current.error_network);
}

class MaintenanceException extends AppException {
  MaintenanceException() : super(S.current.error, S.current.server_error);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException() : super(S.current.error, S.current.unauthorized);
}

class UnAuthenticatedException extends AppException {
  UnAuthenticatedException() : super(S.current.error, S.current.unauthenticated);
}

class ApiDataException extends AppException {
  const ApiDataException({String title = '', String message = ''}) : super(title, message);

  factory ApiDataException.fromJson(Map<String, dynamic> json) {
    try {
      return ApiDataException(
        message: json['message'] as String? ?? '',
        title: json['error'] as String? ?? '',
      );
    } catch (e) {
      return ApiDataException(
        title: S.current.error,
        message: S.current.something_went_wrong,
      );
    }
  }
}
