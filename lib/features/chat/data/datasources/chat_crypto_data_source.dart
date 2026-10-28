import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rose_gold_app_messenger/features/core/security/passphrase_generator.dart';

abstract class ChatCryptoDataSource {
  Future<void> initLocalKeys({required String userId});
  Future<String> getOrGeneratePassphrase({required String userId});
  Future<void> setPassphrase({
    required String userId,
    required String passphrase,
  });
  Future<String> regenerateRandomPassphrase({required String userId});
  Future<String> getPublicKeyBase64({required String userId});
  Future<String> getKeyFingerprint({required String userId});
  Future<SecretKey> deriveSharedKey({
    required String userId,
    required String peerPublicKeyBase64,
    required String roomId,
  });
  Future<void> rememberRoomPeerKey({
    required String userId,
    required String roomId,
    required String peerPublicKeyBase64,
  });
  Future<List<String>> getRememberedRoomPeerKeys({
    required String userId,
    required String roomId,
  });
  Future<({String ciphertext, String nonce, String fingerprint})> encrypt({
    required String userId,
    required String plainText,
    required SecretKey secretKey,
  });
  Future<String> decrypt({
    required String ciphertextBase64,
    required String nonceBase64,
    required SecretKey secretKey,
  });
}

class ChatCryptoDataSourceImpl extends ChatCryptoDataSource {
  new({required this.secureStorage});

  final FlutterSecureStorage secureStorage;
  final KeyExchangeAlgorithm _keyExchange = X25519();
  final Cipher _cipher = Chacha20.poly1305Aead();
  final Sha256 _sha256 = Sha256();

  final Map<String, KeyPair> _keyPairsByUser = <String, KeyPair>{};
  final Map<String, SecretKey> _cachedDerivedKeys = <String, SecretKey>{};

  String _passphraseStorageKey(String userId) => 'e2ee_passphrase_$userId';
  String _privateKeyStorageKey(String userId) => 'e2ee_private_key_x25519_$userId';
  String _publicKeyStorageKey(String userId) => 'e2ee_public_key_x25519_$userId';
  String _roomPeersStorageKey(String userId, String roomId) => 'e2ee_room_peers_${userId}_$roomId';

  Future<KeyPair> _deriveKeyPairFromPassphrase({
    required String passphrase,
    required String userId,
  }) async {
    final Pbkdf2 pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 10000,
      bits: 256,
    );

    final SecretKey derivedSecret = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(passphrase.trim())),
      nonce: utf8.encode('salt:e2ee:$userId'),
    );

    final List<int> seed = await derivedSecret.extractBytes();
    return await _keyExchange.newKeyPairFromSeed(seed);
  }

  @override
  Future<String> getOrGeneratePassphrase({required String userId}) async {
    final String phraseKey = _passphraseStorageKey(userId);
    final String? existingPhrase = await secureStorage.read(key: phraseKey);

    if (existingPhrase != null && existingPhrase.trim().isNotEmpty) {
      return existingPhrase.trim();
    }

    final String newPhrase = PassphraseGenerator.generateRandomPassphrase();
    await setPassphrase(userId: userId, passphrase: newPhrase);
    return newPhrase;
  }

  @override
  Future<void> setPassphrase({
    required String userId,
    required String passphrase,
  }) async {
    final String trimmedPhrase = passphrase.trim();
    if (trimmedPhrase.isEmpty) {
      throw const FormatException('La phrase secrète ne peut pas être vide');
    }

    final KeyPair keyPair = await _deriveKeyPairFromPassphrase(
      passphrase: trimmedPhrase,
      userId: userId,
    );

    final List<int> privateBytes = await (keyPair as SimpleKeyPair).extractPrivateKeyBytes();
    final PublicKey publicObj = await keyPair.extractPublicKey();

    await secureStorage.write(
      key: _passphraseStorageKey(userId),
      value: trimmedPhrase,
    );
    await secureStorage.write(
      key: _privateKeyStorageKey(userId),
      value: base64Encode(privateBytes),
    );
    await secureStorage.write(
      key: _publicKeyStorageKey(userId),
      value: base64Encode((publicObj as SimplePublicKey).bytes),
    );

    _keyPairsByUser[userId] = keyPair;
    _cachedDerivedKeys.clear();
  }

  @override
  Future<String> regenerateRandomPassphrase({required String userId}) async {
    final String newPhrase = PassphraseGenerator.generateRandomPassphrase();
    await setPassphrase(userId: userId, passphrase: newPhrase);
    return newPhrase;
  }

  @override
  Future<void> initLocalKeys({required String userId}) async {
    if (_keyPairsByUser.containsKey(userId)) {
      return;
    }

    final String phraseKey = _passphraseStorageKey(userId);
    final String? storedPhrase = await secureStorage.read(key: phraseKey);

    if (storedPhrase == null || storedPhrase.trim().isEmpty) {
      // Première initialisation : génération automatique d'une phrase aléatoire de 12 mots
      await getOrGeneratePassphrase(userId: userId);
      return;
    }

    final String privStorageKey = _privateKeyStorageKey(userId);
    final String pubStorageKey = _publicKeyStorageKey(userId);

    final String? privateKeyBase64 = await secureStorage.read(key: privStorageKey);
    final String? publicKeyBase64 = await secureStorage.read(key: pubStorageKey);

    if (privateKeyBase64 != null && publicKeyBase64 != null) {
      final List<int> privateBytes = base64Decode(privateKeyBase64);
      final List<int> publicBytes = base64Decode(publicKeyBase64);
      _keyPairsByUser[userId] = SimpleKeyPairData(
        privateBytes,
        publicKey: SimplePublicKey(publicBytes, type: KeyPairType.x25519),
        type: KeyPairType.x25519,
      );
    } else {
      // Re-dériver depuis la phrase si les octets étaient absents
      await setPassphrase(userId: userId, passphrase: storedPhrase);
    }
  }

  Future<KeyPair> _getKeyPair(String userId) async {
    if (!_keyPairsByUser.containsKey(userId)) {
      await initLocalKeys(userId: userId);
    }
    return _keyPairsByUser[userId]!;
  }

  @override
  Future<String> getPublicKeyBase64({required String userId}) async {
    final KeyPair keyPair = await _getKeyPair(userId);
    final PublicKey pub = await keyPair.extractPublicKey();
    return base64Encode((pub as SimplePublicKey).bytes);
  }

  @override
  Future<String> getKeyFingerprint({required String userId}) async {
    final KeyPair keyPair = await _getKeyPair(userId);
    final PublicKey pub = await keyPair.extractPublicKey();
    final Hash hash = await _sha256.hash((pub as SimplePublicKey).bytes);
    return base64Encode(hash.bytes);
  }

  @override
  Future<SecretKey> deriveSharedKey({
    required String userId,
    required String peerPublicKeyBase64,
    required String roomId,
  }) async {
    final String cacheKey = '$userId:$roomId:$peerPublicKeyBase64';
    if (_cachedDerivedKeys.containsKey(cacheKey)) {
      return _cachedDerivedKeys[cacheKey]!;
    }

    final KeyPair keyPair = await _getKeyPair(userId);

    final SimplePublicKey peerPublicKey = SimplePublicKey(
      base64Decode(peerPublicKeyBase64),
      type: KeyPairType.x25519,
    );

    final SecretKey sharedSecret = await _keyExchange.sharedSecretKey(
      keyPair: keyPair,
      remotePublicKey: peerPublicKey,
    );

    final Hkdf hkdf = Hkdf(
      hmac: Hmac.sha256(),
      outputLength: 32,
    );

    final SecretKey derivedKey = await hkdf.deriveKey(
      secretKey: sharedSecret,
      info: utf8.encode('room:$roomId'),
    );

    _cachedDerivedKeys[cacheKey] = derivedKey;
    return derivedKey;
  }

  @override
  Future<void> rememberRoomPeerKey({
    required String userId,
    required String roomId,
    required String peerPublicKeyBase64,
  }) async {
    final String storageKey = _roomPeersStorageKey(userId, roomId);
    final List<String> existing = await getRememberedRoomPeerKeys(
      userId: userId,
      roomId: roomId,
    );
    if (!existing.contains(peerPublicKeyBase64)) {
      final List<String> updated = <String>[...existing, peerPublicKeyBase64];
      await secureStorage.write(key: storageKey, value: jsonEncode(updated));
    }
  }

  @override
  Future<List<String>> getRememberedRoomPeerKeys({
    required String userId,
    required String roomId,
  }) async {
    final String storageKey = _roomPeersStorageKey(userId, roomId);
    final String? raw = await secureStorage.read(key: storageKey);
    if (raw == null || raw.isEmpty) {
      return <String>[];
    }
    try {
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.whereType<String>().toList();
    } on Exception {
      return <String>[];
    }
  }

  @override
  Future<({String ciphertext, String nonce, String fingerprint})> encrypt({
    required String userId,
    required String plainText,
    required SecretKey secretKey,
  }) async {
    final SecretBox box = await _cipher.encrypt(
      utf8.encode(plainText),
      secretKey: secretKey,
    );
    final String fingerprint = await getKeyFingerprint(userId: userId);
    final Uint8List combined = Uint8List.fromList(<int>[...box.cipherText, ...box.mac.bytes]);

    return (
      ciphertext: base64Encode(combined),
      nonce: base64Encode(box.nonce),
      fingerprint: fingerprint,
    );
  }

  @override
  Future<String> decrypt({
    required String ciphertextBase64,
    required String nonceBase64,
    required SecretKey secretKey,
  }) async {
    final Uint8List combined = base64Decode(ciphertextBase64);
    const int macLength = 16;
    if (combined.length < macLength) {
      throw const FormatException('Payload chiffré invalide');
    }

    final Uint8List cipherBytes = combined.sublist(0, combined.length - macLength);
    final Uint8List macBytes = combined.sublist(combined.length - macLength);

    final SecretBox box = SecretBox(
      cipherBytes,
      nonce: base64Decode(nonceBase64),
      mac: Mac(macBytes),
    );

    final List<int> plainBytes = await _cipher.decrypt(
      box,
      secretKey: secretKey,
    );
    return utf8.decode(plainBytes);
  }
}
