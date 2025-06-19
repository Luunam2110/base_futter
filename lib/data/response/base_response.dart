import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/response/base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  const BaseResponse({
    this.success = false,
    this.message,
    this.statusCode,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) mapper) =>
      _$BaseResponseFromJson(json, mapper);

  final bool success;
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final T? data;
}
