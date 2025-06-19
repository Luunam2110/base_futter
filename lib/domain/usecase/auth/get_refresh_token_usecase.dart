import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart' show Result, runCatching;
import 'package:dafactory/domain/repository/auth_repository.dart' show AuthenticationRepository;

mixin GetRefreshTokenUseCase {
  AuthenticationRepository get _repo => getIt<AuthenticationRepository>();

  Result<String> getRefreshToken() {
    return runCatching<String?, String>(
      _repo.getRefreshToken,
      (token) => token ?? '',
    );
  }
}

class GetRefreshTokenUseCaseImpl with GetRefreshTokenUseCase {}
