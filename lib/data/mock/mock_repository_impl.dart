import 'package:dafactory/data/request/auth/sign_in_request.dart';
import 'package:dafactory/data/response/auth/refresh_token_response.dart';
import 'package:dafactory/data/response/auth/sign_in_response.dart';
import 'package:dafactory/data/response/base_response.dart';
import 'package:dafactory/domain/repository/locale_repository.dart';

import '../../domain/repository/auth_repository.dart' show AuthenticationRepository;
import '../../domain/repository/theme_repository.dart' show ThemeRepository;

class MockRepositoryImpl implements AuthenticationRepository, ThemeRepository, LocaleRepository {
  @override
  void clearAuthInfo() {
    // TODO: implement clearAuthInfo
  }

  @override
  void deleteToken() {
    // TODO: implement deleteToken
  }

  @override
  String? getRefreshToken() {
    // TODO: implement getRefreshToken
    return null;
  }

  @override
  String? getToken() {
    // TODO: implement getToken
    return null;
  }

  @override
  String loadThemeMode() {
    // TODO: implement loadThemeMode
    return 'system';
  }

  @override
  void saveAuthInfo({String? token, String? refreshToken}) {
    // TODO: implement saveAuthInfo
  }

  @override
  void saveThemeMode(String mode) {
    // TODO: implement saveThemeMode
  }

  @override
  Future<BaseResponse<SignInResponse>> login(LoginRequest request) async {
    Future.delayed(const Duration(seconds: 2));
    return BaseResponse(
      success: true,
      data: SignInResponse(
        accessToken: 'token',
        refreshToken: 'token',
      ),
    );
  }

  @override
  Future<BaseResponse<RefreshTokenResponse>> refreshToken(String refreshToken) async {
    return BaseResponse(
        success: true,
        data: RefreshTokenResponse(
          accessToken: 'token',
          refreshToken: 'token',
        ));
  }

  @override
  String loadLocale() {
    return 'en';
  }

  @override
  void saveLocale(String locale) {
    // TODO: implement saveLocale
  }

  @override
  Future<LoginRequest?> getAccount() {
    return Future.value(
      LoginRequest(
        'email',
        'password',
      ),
    );
  }

  @override
  Future<void> saveAccount(LoginRequest account) {
    return Future.value();
  }
}
