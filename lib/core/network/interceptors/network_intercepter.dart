import 'package:dafactory/core/network/network_checker.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!(await NetworkChecker.check())) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: NetworkInterceptor(),
          type: DioExceptionType.badResponse,
        ),
      );
    }
    return handler.next(options);
  }
}
