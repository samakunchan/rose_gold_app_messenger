import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:rose_gold_app_messenger/features/core/database/tables/local_messages_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: <Type>[LocalMessages])
class AppDatabase extends _$AppDatabase {
  new() : super(_openConnection());
  new forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.addColumn(localMessages, localMessages.attachmentJson);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'rose_gold_messenger');
  }
}
