import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart';
import 'package:dafactory/data/response/auth/refresh_token_response.dart';
import 'package:dafactory/data/response/base_response.dart' show BaseResponse;
import 'package:dafactory/domain/repository/auth_repository.dart' show AuthenticationRepository;


class RefreshTokenUseCase {
  final _repo = getIt<AuthenticationRepository>();

  Future<Result<String>> call(String refreshToken) async {
    return runCatchingAsync<BaseResponse<RefreshTokenResponse>, String>(
      () async {
        final response = await _repo.refreshToken(refreshToken);
        _repo.saveAuthInfo(
          token: response.data?.accessToken ?? '',
          refreshToken: response.data?.refreshToken ?? '',
        );
        return response;
      },
      (res) => res.data?.accessToken ?? '',
    );
  }
}
