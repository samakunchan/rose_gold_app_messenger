import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String rememberMeCredentialKey = 'CREDENTIALS_WITH_REMEMBER_ME_KEY';

abstract class CacheDataSource {
  Future<String?> getSavedCredentials();
  Future<void> savedCredentials({required String credentials});
  Future<void> deleteCredentials();
}

class CacheDataSourceImpl implements CacheDataSource {
  new({required this.storage});

  final FlutterSecureStorage storage;

  @override
  Future<String?> getSavedCredentials() async {
    return await storage.read(key: rememberMeCredentialKey);
  }

  @override
  Future<void> savedCredentials({required String credentials}) async {
    await storage.write(key: rememberMeCredentialKey, value: credentials);
  }

  @override
  Future<void> deleteCredentials() async {
    if (await storage.containsKey(key: rememberMeCredentialKey)) {
      await storage.delete(key: rememberMeCredentialKey);
    }
  }
}
