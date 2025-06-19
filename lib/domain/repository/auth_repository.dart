import 'package:dafactory/data/request/auth/sign_in_request.dart';
import 'package:dafactory/data/response/auth/refresh_token_response.dart';
import 'package:dafactory/data/response/auth/sign_in_response.dart';
import 'package:dafactory/data/response/base_response.dart';

mixin AuthenticationRepository {
  String? getToken();

  String? getRefreshToken();

  void saveAuthInfo({String? token, String? refreshToken});

  void deleteToken();

  void clearAuthInfo();

  Future<BaseResponse<RefreshTokenResponse>> refreshToken(String refreshToken);

  Future<BaseResponse<SignInResponse>> login(LoginRequest request);

  Future<void> saveAccount(LoginRequest account);

  Future<LoginRequest?> getAccount();
}
