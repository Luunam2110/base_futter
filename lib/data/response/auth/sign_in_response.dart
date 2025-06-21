import 'package:dafactory/domain/model/auth/unauthorized_model.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/data/response/auth/sign_in_response.g.dart';

@JsonSerializable(createToJson: false)
class SignInResponse {
  final String accessToken;
  final String refreshToken;

  SignInResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);

  UnAuthorizedModel toModel() {
    return UnAuthorizedModel(accessToken, refreshToken);
  }
}
