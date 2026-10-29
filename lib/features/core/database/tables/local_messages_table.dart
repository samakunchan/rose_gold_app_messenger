import 'package:drift/drift.dart';

class LocalMessages extends Table {
  TextColumn get id => text()();
  TextColumn get roomId => text()();
  TextColumn get senderId => text()();
  TextColumn get decryptedContent => text()();
  TextColumn get keyFingerprint => text()();
  TextColumn get mediaUrl => text().nullable()();
  TextColumn get attachmentJson => text().nullable()();
  TextColumn get createdAt => text()();

  @override
  Set<Column<Object>>? get primaryKey => <Column<Object>>{id};
}
