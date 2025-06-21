import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/extensions/string_ext.dart';
import 'package:dafactory/core/result/result.dart' show Result, runCatching;
import 'package:dafactory/domain/repository/auth_repository.dart';

class GetAuthStatusUseCase {
  AuthenticationRepository get _repo => getIt<AuthenticationRepository>();

  Result<bool> call() {
    return runCatching<String?, bool>(
      _repo.getToken,
      (token) => token.isStrNotEmpty,
    );
  }
}
