import 'dart:convert';

import 'package:dafactory/data/request/auth/sign_in_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureService {
  static const _secureAccount = '_SECURE_ACCOUNT';

  AndroidOptions _getAndroidOptions() {
    return AndroidOptions()..params['encryptedSharedPreferences'] = 'true';
  }

  IOSOptions _getIOSOptions() {
    return const IOSOptions(accessibility: IOSAccessibility.first_unlock);
  }

  // Create storage
  final storage = const FlutterSecureStorage();

  Future<void> saveAccount(LoginRequest account) async {
    await storage.write(
      key: _secureAccount,
      value: const JsonEncoder().convert(account.toJson()),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<LoginRequest?> getAccount() async {
    final json = await storage.read(
      key: _secureAccount,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return json == null ? null : LoginRequest.fromJson(const JsonDecoder().convert(json));
  }
}
