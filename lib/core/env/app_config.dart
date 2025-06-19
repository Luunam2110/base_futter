import 'package:firebase_core/firebase_core.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../generated/core/env/app_config.g.dart';

@JsonSerializable(createToJson: false)
class AppConfig {
  @JsonKey(name: 'app_name')
  String appName;

  @JsonKey(name: 'base_url')
  String baseUrl;

  @JsonKey(name: 'firebase_config')
  FirebaseSettings firebaseConfig;

  AppConfig(this.appName, this.baseUrl, this.firebaseConfig);

  static late final AppConfig instance;

  bool get isMock => const bool.fromEnvironment('IS_MOCK', defaultValue: false);

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
}

@JsonSerializable(createToJson: false)
class FirebaseSettings {
  FirebaseSettings(
    this.apiKey,
    this.authDomain,
    this.projectId,
    this.storageBucket,
    this.messagingSenderId,
    this.appId,
    this.measurementId,
  );

  @JsonKey(name: 'api_key')
  String apiKey;
  @JsonKey(name: 'auth_domain')
  String authDomain;
  @JsonKey(name: 'project_id')
  String projectId;
  @JsonKey(name: 'storage_bucket')
  String storageBucket;
  @JsonKey(name: 'messaging_sender_id')
  String messagingSenderId;
  @JsonKey(name: 'app_id')
  String appId;
  @JsonKey(name: 'measurement_id')
  String measurementId;

  factory FirebaseSettings.fromJson(Map<String, dynamic> json) => _$FirebaseSettingsFromJson(json);

  FirebaseOptions get option => FirebaseOptions(
        apiKey: apiKey,
        authDomain: authDomain,
        projectId: projectId,
        storageBucket: storageBucket,
        messagingSenderId: messagingSenderId,
        appId: appId,
        measurementId: measurementId,
      );
}
