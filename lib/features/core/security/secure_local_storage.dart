import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SecureLocalStorage extends LocalStorage {
  new(FlutterSecureStorage storage, String storageKey) : _storage = storage, _storageKey = storageKey;
  final FlutterSecureStorage _storage;
  final String _storageKey;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() async {
    return await _storage.containsKey(key: _storageKey);
  }

  @override
  Future<String?> accessToken() async {
    return await _storage.read(key: _storageKey);
  }

  @override
  Future<void> removePersistedSession() async {
    await _storage.delete(key: _storageKey);
  }

  @override
  Future<void> persistSession(String persistSessionString) async {
    await _storage.write(key: _storageKey, value: persistSessionString);
  }
}
