import 'dart:convert';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_crypto_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/core/database/app_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ChatCryptoDataSource cryptoDataSource;
  late AppDatabase db;
  late ChatLocalDataSource localDataSource;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
    cryptoDataSource = ChatCryptoDataSourceImpl(secureStorage: const FlutterSecureStorage());
    db = AppDatabase.forTesting(NativeDatabase.memory());
    localDataSource = ChatLocalDataSourceImpl(database: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Hybrid Media Encryption: encrypt and decrypt raw media bytes', () async {
    final Uint8List originalBytes = Uint8List.fromList(utf8.encode('Fake photo JPEG binary bytes'));

    final ({Uint8List encryptedBytes, String fileKeyBase64, String nonceBase64}) encrypted = await cryptoDataSource.encryptMediaFile(
      originalBytes,
    );

    expect(encrypted.encryptedBytes, isNot(equals(originalBytes)));
    expect(encrypted.fileKeyBase64.isNotEmpty, isTrue);
    expect(encrypted.nonceBase64.isNotEmpty, isTrue);

    final Uint8List decryptedBytes = await cryptoDataSource.decryptMediaFile(
      encryptedBytes: encrypted.encryptedBytes,
      fileKeyBase64: encrypted.fileKeyBase64,
      nonceBase64: encrypted.nonceBase64,
    );

    expect(decryptedBytes, equals(originalBytes));
    expect(utf8.decode(decryptedBytes), equals('Fake photo JPEG binary bytes'));
  });

  test('EncryptedMediaAttachment JSON serialization roundtrip', () {
    const EncryptedMediaAttachment attachment = EncryptedMediaAttachment(
      storagePath: 'user123/photo.jpg.enc',
      fileKeyBase64: 'kEyBaSe64==',
      nonceBase64: 'NoNcEbAsE64=',
      fileName: 'photo.jpg',
      fileSize: 2048,
      mimeType: 'image/jpeg',
    );

    final Map<String, dynamic> json = attachment.toJson();
    final EncryptedMediaAttachment deserialized = EncryptedMediaAttachment.fromJson(json);

    expect(deserialized, equals(attachment));
    expect(deserialized.storagePath, equals('user123/photo.jpg.enc'));
    expect(deserialized.fileSize, equals(2048));
  });

  test('Drift local cache persists and restores EncryptedMediaAttachment', () async {
    const EncryptedMediaAttachment attachment = EncryptedMediaAttachment(
      storagePath: 'user123/video.mp4.enc',
      fileKeyBase64: 'secretKeyBase64==',
      nonceBase64: 'nonceBase64==',
      fileName: 'secret_video.mp4',
      fileSize: 1048576,
      mimeType: 'video/mp4',
    );

    const MessageEntity messageWithMedia = MessageEntity(
      id: 'm_media_1',
      roomId: 'room_abc',
      senderId: 'user_alice',
      decryptedContent: 'Regarde cette vidéo',
      keyFingerprint: 'fp_media',
      createdAt: '2026-10-28T12:00:00.000Z',
      attachment: attachment,
    );

    await localDataSource.saveMessage(messageWithMedia);

    final List<MessageEntity> roomMessages = await localDataSource.getRoomMessages(roomId: 'room_abc');
    expect(roomMessages.length, equals(1));

    final MessageEntity retrieved = roomMessages.first;
    expect(retrieved.id, equals('m_media_1'));
    expect(retrieved.attachment, isNotNull);
    expect(retrieved.attachment!.fileName, equals('secret_video.mp4'));
    expect(retrieved.attachment!.fileKeyBase64, equals('secretKeyBase64=='));
    expect(retrieved.attachment!.mimeType, equals('video/mp4'));
  });
}
