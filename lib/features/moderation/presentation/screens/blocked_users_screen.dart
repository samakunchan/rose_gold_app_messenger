import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/signals/moderation_signals.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/view_models/blocked_user_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BlockedUsersScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(kGetIt<ModerationSignals>().fetchBlockedUsers());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ModerationSignals moderationSignals = kGetIt<ModerationSignals>();

    return Scaffold(
      appBar: AppBar(title: const Text('Utilisateurs bloqués')),
      body: SafeArea(
        child: SignalBuilder(
          builder: (_) {
            final bool isLoading = moderationSignals.isLoading.value;
            final List<BlockedUserViewModel> blockedUsers = moderationSignals.blockedUsers.value;

            if (isLoading && blockedUsers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (blockedUsers.isEmpty) {
              return Center(
                child: Padding(
                  padding: .all(AppSpacing.spaceLg.value),
                  child: Column(
                    mainAxisSize: .min,
                    spacing: AppSpacing.spaceSm.value,
                    children: <Widget>[
                      Icon(Icons.block_outlined, size: 48, color: theme.colorScheme.outline),
                      Text(
                        'Aucun utilisateur bloqué',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        'Les utilisateurs que vous bloquez ne pourront plus vous envoyer d’invitations.',
                        textAlign: .center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: .all(AppSpacing.spaceBase.value),
              itemCount: blockedUsers.length,
              separatorBuilder: (_, _) => SizedBox(height: AppSpacing.spaceSm.value),
              itemBuilder: (BuildContext context, int index) {
                final BlockedUserViewModel user = blockedUsers[index];

                return Card(
                  child: Padding(
                    padding: .all(AppSpacing.spaceMd.value),
                    child: Row(
                      spacing: AppSpacing.spaceMd.value,
                      children: <Widget>[
                        MonogramUser(username: user.username),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: <Widget>[
                              Text(
                                user.username,
                                style: theme.textTheme.titleSmall?.copyWith(fontWeight: .bold),
                              ),
                              if (user.userTag != null && user.userTag!.isNotEmpty)
                                Text(
                                  '@${user.userTag}',
                                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                                ),
                              if (user.blockedTimeAgo.isNotEmpty)
                                Text(
                                  'Bloqué ${user.blockedTimeAgo}',
                                  style: theme.textTheme.labelSmall?.copyWith(color: kTaupeMutedTextColor),
                                ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            final bool success = await moderationSignals.unblockUser(
                              blockedUserId: user.blockedUserId,
                            );
                            if (success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${user.displayName} a été débloqué.'),
                                  behavior: .floating,
                                ),
                              );
                            }
                          },
                          child: const Text('Débloquer'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
