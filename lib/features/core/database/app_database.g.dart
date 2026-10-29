// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalMessagesTable extends LocalMessages
    with TableInfo<$LocalMessagesTable, LocalMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
    'room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decryptedContentMeta = const VerificationMeta(
    'decryptedContent',
  );
  @override
  late final GeneratedColumn<String> decryptedContent = GeneratedColumn<String>(
    'decrypted_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyFingerprintMeta = const VerificationMeta(
    'keyFingerprint',
  );
  @override
  late final GeneratedColumn<String> keyFingerprint = GeneratedColumn<String>(
    'key_fingerprint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaUrlMeta = const VerificationMeta(
    'mediaUrl',
  );
  @override
  late final GeneratedColumn<String> mediaUrl = GeneratedColumn<String>(
    'media_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attachmentJsonMeta = const VerificationMeta(
    'attachmentJson',
  );
  @override
  late final GeneratedColumn<String> attachmentJson = GeneratedColumn<String>(
    'attachment_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    roomId,
    senderId,
    decryptedContent,
    keyFingerprint,
    mediaUrl,
    attachmentJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('decrypted_content')) {
      context.handle(
        _decryptedContentMeta,
        decryptedContent.isAcceptableOrUnknown(
          data['decrypted_content']!,
          _decryptedContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_decryptedContentMeta);
    }
    if (data.containsKey('key_fingerprint')) {
      context.handle(
        _keyFingerprintMeta,
        keyFingerprint.isAcceptableOrUnknown(
          data['key_fingerprint']!,
          _keyFingerprintMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_keyFingerprintMeta);
    }
    if (data.containsKey('media_url')) {
      context.handle(
        _mediaUrlMeta,
        mediaUrl.isAcceptableOrUnknown(data['media_url']!, _mediaUrlMeta),
      );
    }
    if (data.containsKey('attachment_json')) {
      context.handle(
        _attachmentJsonMeta,
        attachmentJson.isAcceptableOrUnknown(
          data['attachment_json']!,
          _attachmentJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      decryptedContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decrypted_content'],
      )!,
      keyFingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_fingerprint'],
      )!,
      mediaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_url'],
      ),
      attachmentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalMessagesTable createAlias(String alias) {
    return $LocalMessagesTable(attachedDatabase, alias);
  }
}

class LocalMessage extends DataClass implements Insertable<LocalMessage> {
  final String id;
  final String roomId;
  final String senderId;
  final String decryptedContent;
  final String keyFingerprint;
  final String? mediaUrl;
  final String? attachmentJson;
  final String createdAt;
  const LocalMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.decryptedContent,
    required this.keyFingerprint,
    this.mediaUrl,
    this.attachmentJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['room_id'] = Variable<String>(roomId);
    map['sender_id'] = Variable<String>(senderId);
    map['decrypted_content'] = Variable<String>(decryptedContent);
    map['key_fingerprint'] = Variable<String>(keyFingerprint);
    if (!nullToAbsent || mediaUrl != null) {
      map['media_url'] = Variable<String>(mediaUrl);
    }
    if (!nullToAbsent || attachmentJson != null) {
      map['attachment_json'] = Variable<String>(attachmentJson);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  LocalMessagesCompanion toCompanion(bool nullToAbsent) {
    return LocalMessagesCompanion(
      id: Value(id),
      roomId: Value(roomId),
      senderId: Value(senderId),
      decryptedContent: Value(decryptedContent),
      keyFingerprint: Value(keyFingerprint),
      mediaUrl: mediaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaUrl),
      attachmentJson: attachmentJson == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentJson),
      createdAt: Value(createdAt),
    );
  }

  factory LocalMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMessage(
      id: serializer.fromJson<String>(json['id']),
      roomId: serializer.fromJson<String>(json['roomId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      decryptedContent: serializer.fromJson<String>(json['decryptedContent']),
      keyFingerprint: serializer.fromJson<String>(json['keyFingerprint']),
      mediaUrl: serializer.fromJson<String?>(json['mediaUrl']),
      attachmentJson: serializer.fromJson<String?>(json['attachmentJson']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'roomId': serializer.toJson<String>(roomId),
      'senderId': serializer.toJson<String>(senderId),
      'decryptedContent': serializer.toJson<String>(decryptedContent),
      'keyFingerprint': serializer.toJson<String>(keyFingerprint),
      'mediaUrl': serializer.toJson<String?>(mediaUrl),
      'attachmentJson': serializer.toJson<String?>(attachmentJson),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  LocalMessage copyWith({
    String? id,
    String? roomId,
    String? senderId,
    String? decryptedContent,
    String? keyFingerprint,
    Value<String?> mediaUrl = const Value.absent(),
    Value<String?> attachmentJson = const Value.absent(),
    String? createdAt,
  }) => LocalMessage(
    id: id ?? this.id,
    roomId: roomId ?? this.roomId,
    senderId: senderId ?? this.senderId,
    decryptedContent: decryptedContent ?? this.decryptedContent,
    keyFingerprint: keyFingerprint ?? this.keyFingerprint,
    mediaUrl: mediaUrl.present ? mediaUrl.value : this.mediaUrl,
    attachmentJson: attachmentJson.present
        ? attachmentJson.value
        : this.attachmentJson,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalMessage copyWithCompanion(LocalMessagesCompanion data) {
    return LocalMessage(
      id: data.id.present ? data.id.value : this.id,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      decryptedContent: data.decryptedContent.present
          ? data.decryptedContent.value
          : this.decryptedContent,
      keyFingerprint: data.keyFingerprint.present
          ? data.keyFingerprint.value
          : this.keyFingerprint,
      mediaUrl: data.mediaUrl.present ? data.mediaUrl.value : this.mediaUrl,
      attachmentJson: data.attachmentJson.present
          ? data.attachmentJson.value
          : this.attachmentJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMessage(')
          ..write('id: $id, ')
          ..write('roomId: $roomId, ')
          ..write('senderId: $senderId, ')
          ..write('decryptedContent: $decryptedContent, ')
          ..write('keyFingerprint: $keyFingerprint, ')
          ..write('mediaUrl: $mediaUrl, ')
          ..write('attachmentJson: $attachmentJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    roomId,
    senderId,
    decryptedContent,
    keyFingerprint,
    mediaUrl,
    attachmentJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMessage &&
          other.id == this.id &&
          other.roomId == this.roomId &&
          other.senderId == this.senderId &&
          other.decryptedContent == this.decryptedContent &&
          other.keyFingerprint == this.keyFingerprint &&
          other.mediaUrl == this.mediaUrl &&
          other.attachmentJson == this.attachmentJson &&
          other.createdAt == this.createdAt);
}

class LocalMessagesCompanion extends UpdateCompanion<LocalMessage> {
  final Value<String> id;
  final Value<String> roomId;
  final Value<String> senderId;
  final Value<String> decryptedContent;
  final Value<String> keyFingerprint;
  final Value<String?> mediaUrl;
  final Value<String?> attachmentJson;
  final Value<String> createdAt;
  final Value<int> rowid;
  const LocalMessagesCompanion({
    this.id = const Value.absent(),
    this.roomId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.decryptedContent = const Value.absent(),
    this.keyFingerprint = const Value.absent(),
    this.mediaUrl = const Value.absent(),
    this.attachmentJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalMessagesCompanion.insert({
    required String id,
    required String roomId,
    required String senderId,
    required String decryptedContent,
    required String keyFingerprint,
    this.mediaUrl = const Value.absent(),
    this.attachmentJson = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       roomId = Value(roomId),
       senderId = Value(senderId),
       decryptedContent = Value(decryptedContent),
       keyFingerprint = Value(keyFingerprint),
       createdAt = Value(createdAt);
  static Insertable<LocalMessage> custom({
    Expression<String>? id,
    Expression<String>? roomId,
    Expression<String>? senderId,
    Expression<String>? decryptedContent,
    Expression<String>? keyFingerprint,
    Expression<String>? mediaUrl,
    Expression<String>? attachmentJson,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roomId != null) 'room_id': roomId,
      if (senderId != null) 'sender_id': senderId,
      if (decryptedContent != null) 'decrypted_content': decryptedContent,
      if (keyFingerprint != null) 'key_fingerprint': keyFingerprint,
      if (mediaUrl != null) 'media_url': mediaUrl,
      if (attachmentJson != null) 'attachment_json': attachmentJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? roomId,
    Value<String>? senderId,
    Value<String>? decryptedContent,
    Value<String>? keyFingerprint,
    Value<String?>? mediaUrl,
    Value<String?>? attachmentJson,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalMessagesCompanion(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      decryptedContent: decryptedContent ?? this.decryptedContent,
      keyFingerprint: keyFingerprint ?? this.keyFingerprint,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      attachmentJson: attachmentJson ?? this.attachmentJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (decryptedContent.present) {
      map['decrypted_content'] = Variable<String>(decryptedContent.value);
    }
    if (keyFingerprint.present) {
      map['key_fingerprint'] = Variable<String>(keyFingerprint.value);
    }
    if (mediaUrl.present) {
      map['media_url'] = Variable<String>(mediaUrl.value);
    }
    if (attachmentJson.present) {
      map['attachment_json'] = Variable<String>(attachmentJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMessagesCompanion(')
          ..write('id: $id, ')
          ..write('roomId: $roomId, ')
          ..write('senderId: $senderId, ')
          ..write('decryptedContent: $decryptedContent, ')
          ..write('keyFingerprint: $keyFingerprint, ')
          ..write('mediaUrl: $mediaUrl, ')
          ..write('attachmentJson: $attachmentJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalMessagesTable localMessages = $LocalMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localMessages];
}

typedef $$LocalMessagesTableCreateCompanionBuilder =
    LocalMessagesCompanion Function({
      required String id,
      required String roomId,
      required String senderId,
      required String decryptedContent,
      required String keyFingerprint,
      Value<String?> mediaUrl,
      Value<String?> attachmentJson,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$LocalMessagesTableUpdateCompanionBuilder =
    LocalMessagesCompanion Function({
      Value<String> id,
      Value<String> roomId,
      Value<String> senderId,
      Value<String> decryptedContent,
      Value<String> keyFingerprint,
      Value<String?> mediaUrl,
      Value<String?> attachmentJson,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $$LocalMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalMessagesTable> {
  $$LocalMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roomId => $composableBuilder(
    column: $table.roomId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decryptedContent => $composableBuilder(
    column: $table.decryptedContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyFingerprint => $composableBuilder(
    column: $table.keyFingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaUrl => $composableBuilder(
    column: $table.mediaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentJson => $composableBuilder(
    column: $table.attachmentJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalMessagesTable> {
  $$LocalMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roomId => $composableBuilder(
    column: $table.roomId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decryptedContent => $composableBuilder(
    column: $table.decryptedContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyFingerprint => $composableBuilder(
    column: $table.keyFingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaUrl => $composableBuilder(
    column: $table.mediaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentJson => $composableBuilder(
    column: $table.attachmentJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalMessagesTable> {
  $$LocalMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get roomId =>
      $composableBuilder(column: $table.roomId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get decryptedContent => $composableBuilder(
    column: $table.decryptedContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keyFingerprint => $composableBuilder(
    column: $table.keyFingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediaUrl =>
      $composableBuilder(column: $table.mediaUrl, builder: (column) => column);

  GeneratedColumn<String> get attachmentJson => $composableBuilder(
    column: $table.attachmentJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalMessagesTable,
          LocalMessage,
          $$LocalMessagesTableFilterComposer,
          $$LocalMessagesTableOrderingComposer,
          $$LocalMessagesTableAnnotationComposer,
          $$LocalMessagesTableCreateCompanionBuilder,
          $$LocalMessagesTableUpdateCompanionBuilder,
          (
            LocalMessage,
            BaseReferences<_$AppDatabase, $LocalMessagesTable, LocalMessage>,
          ),
          LocalMessage,
          PrefetchHooks Function()
        > {
  $$LocalMessagesTableTableManager(_$AppDatabase db, $LocalMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> roomId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> decryptedContent = const Value.absent(),
                Value<String> keyFingerprint = const Value.absent(),
                Value<String?> mediaUrl = const Value.absent(),
                Value<String?> attachmentJson = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalMessagesCompanion(
                id: id,
                roomId: roomId,
                senderId: senderId,
                decryptedContent: decryptedContent,
                keyFingerprint: keyFingerprint,
                mediaUrl: mediaUrl,
                attachmentJson: attachmentJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String roomId,
                required String senderId,
                required String decryptedContent,
                required String keyFingerprint,
                Value<String?> mediaUrl = const Value.absent(),
                Value<String?> attachmentJson = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalMessagesCompanion.insert(
                id: id,
                roomId: roomId,
                senderId: senderId,
                decryptedContent: decryptedContent,
                keyFingerprint: keyFingerprint,
                mediaUrl: mediaUrl,
                attachmentJson: attachmentJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalMessagesTable, LocalMessage>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LocalMessagesTable,
                    LocalMessage
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalMessagesTable,
      LocalMessage,
      $$LocalMessagesTableFilterComposer,
      $$LocalMessagesTableOrderingComposer,
      $$LocalMessagesTableAnnotationComposer,
      $$LocalMessagesTableCreateCompanionBuilder,
      $$LocalMessagesTableUpdateCompanionBuilder,
      (
        LocalMessage,
        BaseReferences<_$AppDatabase, $LocalMessagesTable, LocalMessage>,
      ),
      LocalMessage,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalMessagesTableTableManager get localMessages =>
      $$LocalMessagesTableTableManager(_db, _db.localMessages);
}
