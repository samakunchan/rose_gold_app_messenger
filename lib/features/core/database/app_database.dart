import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:rose_gold_app_messenger/features/core/database/tables/local_messages_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: <Type>[LocalMessages])
class AppDatabase extends _$AppDatabase {
  new() : super(_openConnection());
  new forTesting(super.e);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'rose_gold_messenger');
  }
}
