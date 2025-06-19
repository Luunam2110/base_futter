import 'package:json_annotation/json_annotation.dart';

part '../../../generated/core/env/dev/develop.g.dart';


@JsonLiteral('dev_config.json', asConst: true)
Map<String, dynamic> get configDevEnv => _$configDevEnvJsonLiteral;

@JsonLiteral('dev_firebase_config.json', asConst: true)
Map<String, dynamic> get webFirebaseConfigDev => _$webFirebaseConfigDevJsonLiteral;
