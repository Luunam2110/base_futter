import 'package:dafactory/core/di/module.dart' show getIt;
import 'package:dafactory/core/result/result.dart';
import 'package:dafactory/data/response/auth/sign_in_response.dart';
import 'package:dafactory/data/response/base_response.dart';
import 'package:dafactory/domain/model/auth/unauthorized_model.dart';
import 'package:dafactory/domain/repository/auth_repository.dart' show AuthenticationRepository;

import '../../../data/request/auth/sign_in_request.dart';

mixin LoginUseCase {
  AuthenticationRepository get _repo => getIt<AuthenticationRepository>();

  Future<Result> login(String userName, String password, bool saveAccount) async {
    final loginResult = await runCatchingAsync<BaseResponse<SignInResponse>, UnauthorizedModel>(
      () => _repo.login(LoginRequest(userName, password)),
      (res) => res.data?.toModel() ?? UnauthorizedModel('', ''),
    );
    if (loginResult is Success<UnauthorizedModel> && loginResult.value.accessToken.isNotEmpty) {
      _repo.saveAuthInfo(
        token: loginResult.value.accessToken,
        refreshToken: loginResult.value.refreshToken,
      );
      return Result.success(null);
    } else {
      return Result.error((loginResult as Error).error);
    }
  }
}
