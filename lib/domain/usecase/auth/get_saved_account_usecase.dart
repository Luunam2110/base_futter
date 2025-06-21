import 'package:dafactory/core/di/module.dart';
import 'package:dafactory/core/result/result.dart';
import 'package:dafactory/data/request/auth/sign_in_request.dart';
import 'package:dafactory/domain/model/auth/account_model.dart';
import 'package:dafactory/domain/repository/auth_repository.dart';

class GetSavedAccountUseCase {
  AuthenticationRepository get _repo => getIt<AuthenticationRepository>();

  Future<AccountModel?> call() async {
    final result = await runCatchingAsync<LoginRequest?, AccountModel?>(
      _repo.getAccount,
      (res) {
        if (res != null) {
          return AccountModel(res.username, res.password);
        } else {
          return null;
        }
      },
    );
    if (result is Success<AccountModel?>) {
      return result.value;
    } else {
      return null;
    }
  }
}
