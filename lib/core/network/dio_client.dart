import 'package:dafactory/core/constants/api_constants.dart';
import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/network/interceptors/auth_interceptor.dart' show AuthInterceptor;
import 'package:dafactory/core/network/interceptors/request_interceptor.dart' show RequestInterceptor;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDioInstance();
    return _instance!;
  }

  static Dio _createDioInstance() {
    final options = BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      receiveTimeout: const Duration(milliseconds: ApiConstants.connectTimeOut),
      connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeOut),
      followRedirects: false,
    );
    final dio = Dio(options);
    dio.interceptors.clear();
    dio.interceptors.addAll([
      // Add your interceptors here
      RequestInterceptor(),
      AuthInterceptor(),
    ]);
    if (foundation.kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          maxWidth: 100,
        ),
      );
    }
    return dio;
  }
}
