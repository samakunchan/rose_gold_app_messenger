import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/core/database/app_database.dart';

void main() {
  late AppDatabase db;
  late ChatLocalDataSource dataSource;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = ChatLocalDataSourceImpl(database: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Save, retrieve and search decrypted messages in Drift', () async {
    const MessageEntity message1 = MessageEntity(
      id: 'm1',
      roomId: 'room_1',
      senderId: 'user_alice',
      decryptedContent: 'Rendez-vous secret à 18h',
      keyFingerprint: 'fp1',
      createdAt: '2026-10-27T18:00:00.000Z',
    );

    const MessageEntity message2 = MessageEntity(
      id: 'm2',
      roomId: 'room_1',
      senderId: 'user_bob',
      decryptedContent: 'Parfait, le fichier est envoyé',
      keyFingerprint: 'fp2',
      createdAt: '2026-10-27T18:05:00.000Z',
    );

    await dataSource.saveMessages(<MessageEntity>[message1, message2]);

    final List<MessageEntity> roomMessages = await dataSource.getRoomMessages(roomId: 'room_1');
    expect(roomMessages.length, equals(2));
    expect(roomMessages.first.decryptedContent, equals('Rendez-vous secret à 18h'));

    final List<MessageEntity> searchSecret = await dataSource.searchMessages(query: 'secret');
    expect(searchSecret.length, equals(1));
    expect(searchSecret.first.id, equals('m1'));

    final List<MessageEntity> searchFichier = await dataSource.searchMessages(query: 'fichier', roomId: 'room_1');
    expect(searchFichier.length, equals(1));
    expect(searchFichier.first.id, equals('m2'));

    final List<MessageEntity> searchNotFound = await dataSource.searchMessages(query: 'introuvable');
    expect(searchNotFound.isEmpty, isTrue);
  });
}
