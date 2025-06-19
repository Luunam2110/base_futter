import 'package:dafactory/core/constants/api_constants.dart' show ApiConstants;
import 'package:dafactory/data/request/auth/sign_in_request.dart' show LoginRequest;
import 'package:dafactory/data/response/auth/refresh_token_response.dart' show RefreshTokenResponse;
import 'package:dafactory/data/response/auth/sign_in_response.dart' show SignInResponse;
import 'package:dafactory/data/response/base_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' show factoryMethod;
import 'package:retrofit/retrofit.dart';

part '../../generated/data/services/auth_service.g.dart';

@RestApi()
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(ApiConstants.login)
  Future<BaseResponse<SignInResponse>> login(@Body() LoginRequest body);

  @POST(ApiConstants.refreshToken)
  Future<BaseResponse<RefreshTokenResponse>> refreshToken(@Field('refresh_token') String refreshToken);
}
