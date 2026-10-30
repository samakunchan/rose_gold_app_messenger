import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rose_gold_app_messenger/features/core/database/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class GdprDataSource {
  Future<String> exportUserDataJson();
  Future<String> saveExportToFile(String jsonContent);
  Future<int> clearLocalCache();
}

class GdprDataSourceImpl implements GdprDataSource {
  new({
    required this.supabaseClient,
    required this.database,
    required this.preferences,
    required this.packageInfo,
  });

  final SupabaseClient supabaseClient;
  final AppDatabase database;
  final SharedPreferencesWithCache preferences;
  final PackageInfo packageInfo;

  @override
  Future<String> exportUserDataJson() async {
    final User? currentUser = supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw const AuthException('Utilisateur non connecté.');
    }

    final String userId = currentUser.id;

    final Map<String, dynamic>? profile = await supabaseClient.from('profiles').select().eq('id', userId).maybeSingle();

    final Map<String, dynamic>? publicKeyRow = await supabaseClient.from('user_public_keys').select().eq('user_id', userId).maybeSingle();

    final List<Map<String, dynamic>> roomMemberships = await supabaseClient
        .from('room_members')
        .select('role, joined_at, updated_at, room_id, rooms(id, name, description, avatar_url, created_by, created_at)')
        .eq('user_id', userId);

    final List<Map<String, dynamic>> invitations = await supabaseClient
        .from('room_invitations')
        .select()
        .or('inviter_id.eq.$userId,invited_user_id.eq.$userId')
        .order('created_at', ascending: false);

    final List<Map<String, dynamic>> remoteMessages = await supabaseClient
        .from('messages')
        .select()
        .eq('sender_id', userId)
        .order('created_at', ascending: true);

    final List<Map<String, dynamic>> blockedUsers = await supabaseClient
        .from('blocked_users')
        .select('id, blocked_id, created_at')
        .eq('blocker_id', userId)
        .order('created_at', ascending: false);

    final List<Map<String, dynamic>> reports = await supabaseClient
        .from('reports')
        .select('id, reported_user_id, room_id, invitation_id, reason, details, status, created_at')
        .eq('reporter_id', userId)
        .order('created_at', ascending: false);

    final SimpleSelectStatement<$LocalMessagesTable, LocalMessage> localQuery = database.select(database.localMessages)
      ..where(($LocalMessagesTable tbl) => tbl.senderId.equals(userId))
      ..orderBy(<OrderClauseGenerator<$LocalMessagesTable>>[
        ($LocalMessagesTable tbl) => OrderingTerm.asc(tbl.createdAt),
      ]);

    final List<LocalMessage> localMessages = await localQuery.get();
    final Map<String, LocalMessage> localById = <String, LocalMessage>{
      for (final LocalMessage msg in localMessages) msg.id: msg,
    };

    final List<Map<String, dynamic>> exportedMessages = remoteMessages.map((Map<String, dynamic> row) {
      final String messageId = row['id']?.toString() ?? '';
      final LocalMessage? localMsg = localById[messageId];

      return <String, dynamic>{
        'id': messageId,
        'room_id': row['room_id'],
        'created_at': row['created_at'],
        'decrypted_content': localMsg?.decryptedContent,
        'ciphertext': row['ciphertext'],
        'nonce': row['nonce'],
        'key_fingerprint': row['key_fingerprint'],
        'media_url': row['media_url'],
      };
    }).toList();

    final List<Map<String, dynamic>> formattedInvitations = invitations.map((Map<String, dynamic> row) {
      final bool isSent = row['inviter_id'] == userId;

      return <String, dynamic>{
        'id': row['id'],
        'room_id': row['room_id'],
        'direction': isSent ? 'sent' : 'received',
        'inviter_id': row['inviter_id'],
        'invited_user_id': row['invited_user_id'],
        'status': row['status'],
        'created_at': row['created_at'],
        'updated_at': row['updated_at'],
      };
    }).toList();

    final Map<String, dynamic> payload = <String, dynamic>{
      'export_metadata': <String, dynamic>{
        'exported_at': DateTime.now().toUtc().toIso8601String(),
        'app_name': packageInfo.appName,
        'package_name': packageInfo.packageName,
        'app_version': '${packageInfo.version}+${packageInfo.buildNumber}',
        'gdpr_notice': 'Export généré conformément aux articles 15 et 20 du RGPD (portabilité des données personnelles).',
      },
      'account_and_profile': <String, dynamic>{
        'user_id': userId,
        'email': currentUser.email,
        'auth_created_at': currentUser.createdAt,
        'last_sign_in_at': currentUser.lastSignInAt,
        'profile': profile,
        'e2ee_public_key': publicKeyRow,
      },
      'rooms_memberships': roomMemberships,
      'room_invitations': formattedInvitations,
      'sent_messages': exportedMessages,
      'moderation': <String, dynamic>{
        'blocked_users': blockedUsers,
        'submitted_reports': reports,
      },
      'local_preferences': <String, dynamic>{
        'theme_mode': preferences.getString('local_theme_mode') ?? 'system',
        'language': preferences.getString('local_language') ?? 'fr',
      },
    };

    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  @override
  Future<String> saveExportToFile(String jsonContent) async {
    final String timestamp = DateTime.now().toIso8601String().replaceAll(RegExp('[:.]'), '-');
    final String fileName = 'rose_gold_data_export_$timestamp.json';
    final Directory targetDir = Directory.systemTemp;
    final File file = File('${targetDir.path}/$fileName');
    await file.writeAsString(jsonContent, flush: true);

    return file.path;
  }

  @override
  Future<int> clearLocalCache() async {
    final int deletedMessages = await database.delete(database.localMessages).go();

    int deletedTempFiles = 0;
    try {
      final Directory tempDir = Directory.systemTemp;
      if (tempDir.existsSync()) {
        final List<FileSystemEntity> entities = tempDir.listSync();
        for (final FileSystemEntity entity in entities) {
          final String name = entity.uri.pathSegments.isNotEmpty ? entity.uri.pathSegments.last : '';
          if (name.startsWith('rose_gold_') || name.startsWith('image_picker') || name.startsWith('scaled_')) {
            await entity.delete(recursive: true);
            deletedTempFiles++;
          }
        }
      }
    } on Object catch (_) {
      // Ignore system temp access errors for foreign processes
    }

    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    return deletedMessages + deletedTempFiles;
  }
}
