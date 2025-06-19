import 'package:dafactory/data/local/prefs_service.dart';
import 'package:dafactory/data/local/secure_store_service.dart';
import 'package:dafactory/data/request/auth/sign_in_request.dart';
import 'package:dafactory/data/response/auth/refresh_token_response.dart';
import 'package:dafactory/data/response/auth/sign_in_response.dart';
import 'package:dafactory/data/response/base_response.dart';
import 'package:dafactory/data/services/auth_service.dart';
import 'package:dafactory/domain/repository/auth_repository.dart' show AuthenticationRepository;

class AuthRepositoryImpl implements AuthenticationRepository {
  final PrefsService _prefs;
  final AuthService _service;
  final SecureService _secureService;

  AuthRepositoryImpl(PrefsService prefs, AuthService service, SecureService secureService)
      : _prefs = prefs,
        _secureService = secureService,
        _service = service;

  @override
  void clearAuthInfo() => _prefs.clearAuthInfo();

  @override
  void deleteToken() => _prefs.clearAuthInfo();

  @override
  String? getRefreshToken() => _prefs.getRefreshToken();

  @override
  String? getToken() => _prefs.getAuthToken();

  @override
  void saveAuthInfo({String? token, String? refreshToken}) => _prefs.saveAuthInfo(
        token: token,
        refreshToken: refreshToken,
      );

  @override
  Future<BaseResponse<RefreshTokenResponse>> refreshToken(String refreshToken) {
    return _service.refreshToken(refreshToken);
  }

  @override
  Future<BaseResponse<SignInResponse>> login(LoginRequest request) {
    return _service.login(request);
  }

  @override
  Future<LoginRequest?> getAccount() {
   return _secureService.getAccount();
  }

  @override
  Future<void> saveAccount(LoginRequest account) {
    return _secureService.saveAccount(account);
  }
}
