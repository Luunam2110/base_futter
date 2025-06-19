import 'package:dafactory/core/network/network_handler.dart' show NetworkHandler;
import 'package:dafactory/core/result/app_exception.dart' show AppException, CommonException;
import 'package:dio/dio.dart' show DioException;

import '../utils/logger.dart' show logger;

/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.success(T value) => Success(value);

  /// Create an instance of Result containing an error
  factory Result.error(AppException error) => Error(error);


  T getOrElse(T defaultValue) {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    } else if (this is Error<T>) {
      return defaultValue;
    }
    throw Exception('Invalid Result type');
  }
}

/// Subclass of Result for values
final class Success<T> extends Result<T> {
  const Success(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error(this.error);

  /// Returned error in result
  final AppException error;
}

Result<E> runCatching<T, E>(T Function() block, E Function(T) map) {
  try {
    final data = block();
    return Result.success(map(data));
  } catch (e) {
    logger.e(e);
    return Result.error(CommonException());
  }
}

Future<Result<E>> runCatchingAsync<T, E>(Future<T> Function() block, E Function(T) map) async {
  try {
    final response = await block();
    return Result.success(map(response));
  } catch (e) {
    logger.e(e);
    if (e is DioException) {
      return Result.error(NetworkHandler.handleError(e));
    } else {
      return Result.error(CommonException());
    }
  }
}
