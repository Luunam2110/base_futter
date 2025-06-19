import 'package:json_annotation/json_annotation.dart';

part '../../../generated/core/env/prod/product.g.dart';


@JsonLiteral('prod_config.json', asConst: true)
Map<String, dynamic> get configProdEnv => _$configProdEnvJsonLiteral;

@JsonLiteral('prod_firebase_config.json', asConst: true)
Map<String, dynamic> get webFirebaseConfigProd => _$webFirebaseConfigProdJsonLiteral;

