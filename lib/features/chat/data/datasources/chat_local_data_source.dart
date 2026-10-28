import 'package:drift/drift.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/core/database/app_database.dart';

abstract class ChatLocalDataSource {
  Future<void> saveMessage(MessageEntity message);
  Future<void> saveMessages(List<MessageEntity> messages);
  Future<List<MessageEntity>> getRoomMessages({required String roomId});
  Stream<List<MessageEntity>> watchRoomMessages({required String roomId});
  Future<List<MessageEntity>> searchMessages({required String query, String? roomId});
  Future<void> deleteMessage({required String messageId});
  Future<void> clearRoom({required String roomId});
}

class ChatLocalDataSourceImpl extends ChatLocalDataSource {
  new({required this.database});

  final AppDatabase database;

  @override
  Future<void> saveMessage(MessageEntity message) async {
    await database
        .into(database.localMessages)
        .insertOnConflictUpdate(
          LocalMessagesCompanion.insert(
            id: message.id,
            roomId: message.roomId,
            senderId: message.senderId,
            decryptedContent: message.decryptedContent,
            keyFingerprint: message.keyFingerprint,
            mediaUrl: Value<String?>(message.mediaUrl),
            createdAt: message.createdAt,
          ),
        );
  }

  @override
  Future<void> saveMessages(List<MessageEntity> messages) async {
    await database.batch((Batch batch) {
      batch.insertAllOnConflictUpdate(
        database.localMessages,
        messages.map(
          (MessageEntity message) => LocalMessagesCompanion.insert(
            id: message.id,
            roomId: message.roomId,
            senderId: message.senderId,
            decryptedContent: message.decryptedContent,
            keyFingerprint: message.keyFingerprint,
            mediaUrl: Value<String?>(message.mediaUrl),
            createdAt: message.createdAt,
          ),
        ),
      );
    });
  }

  @override
  Future<List<MessageEntity>> getRoomMessages({required String roomId}) async {
    final SimpleSelectStatement<$LocalMessagesTable, LocalMessage> query = database.select(database.localMessages)
      ..where(($LocalMessagesTable tbl) => tbl.roomId.equals(roomId))
      ..orderBy(<OrderClauseGenerator<$LocalMessagesTable>>[
        ($LocalMessagesTable tbl) => OrderingTerm.asc(tbl.createdAt),
      ]);

    final List<LocalMessage> rows = await query.get();
    return rows.map(_toEntity).toList();
  }

  @override
  Stream<List<MessageEntity>> watchRoomMessages({required String roomId}) {
    final SimpleSelectStatement<$LocalMessagesTable, LocalMessage> query = database.select(database.localMessages)
      ..where(($LocalMessagesTable tbl) => tbl.roomId.equals(roomId))
      ..orderBy(<OrderClauseGenerator<$LocalMessagesTable>>[
        ($LocalMessagesTable tbl) => OrderingTerm.asc(tbl.createdAt),
      ]);

    return query.watch().map(
      (List<LocalMessage> rows) => rows.map(_toEntity).toList(),
    );
  }

  @override
  Future<List<MessageEntity>> searchMessages({
    required String query,
    String? roomId,
  }) async {
    final SimpleSelectStatement<$LocalMessagesTable, LocalMessage> statement = database.select(database.localMessages)
      ..where(($LocalMessagesTable tbl) {
        final Expression<bool> contentMatch = tbl.decryptedContent.like('%$query%');
        if (roomId != null) {
          return contentMatch & tbl.roomId.equals(roomId);
        }
        return contentMatch;
      })
      ..orderBy(<OrderClauseGenerator<$LocalMessagesTable>>[
        ($LocalMessagesTable tbl) => OrderingTerm.desc(tbl.createdAt),
      ]);

    final List<LocalMessage> rows = await statement.get();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<void> deleteMessage({required String messageId}) async {
    await (database.delete(database.localMessages)..where(($LocalMessagesTable tbl) => tbl.id.equals(messageId))).go();
  }

  @override
  Future<void> clearRoom({required String roomId}) async {
    await (database.delete(database.localMessages)..where(($LocalMessagesTable tbl) => tbl.roomId.equals(roomId))).go();
  }

  MessageEntity _toEntity(LocalMessage row) {
    return MessageEntity(
      id: row.id,
      roomId: row.roomId,
      senderId: row.senderId,
      decryptedContent: row.decryptedContent,
      keyFingerprint: row.keyFingerprint,
      createdAt: row.createdAt,
      mediaUrl: row.mediaUrl,
    );
  }
}
