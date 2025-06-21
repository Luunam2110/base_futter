import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart' show Result, runCatching;
import 'package:dafactory/domain/repository/auth_repository.dart' show AuthenticationRepository;

class GetRefreshTokenUseCase {
  AuthenticationRepository get _repo => getIt<AuthenticationRepository>();

  Result<String> call() {
    return runCatching<String?, String>(
      _repo.getRefreshToken,
      (token) => token ?? '',
    );
  }
}
