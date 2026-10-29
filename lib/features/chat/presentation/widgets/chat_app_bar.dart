import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_search_delegate.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/e2ee_passphrase_bottom_sheet.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const new({required this.roomId, required this.roomName, super.key});

  final String roomId;
  final String roomName;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      title: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: <Widget>[
          Text(
            roomName,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
          ),
          Row(
            mainAxisSize: .min,
            children: <Widget>[
              Icon(Icons.lock_rounded, size: 12, color: theme.colorScheme.primary),
              const SizedBox(width: 4),
              Text(
                'Chiffrement de bout en bout',
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          tooltip: 'Rechercher dans ce salon',
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            unawaited(
              showSearch<void>(
                context: context,
                delegate: ChatSearchDelegate(roomId: roomId),
              ),
            );
          },
        ),
        IconButton(
          tooltip: 'Sécurité E2EE',
          icon: const Icon(Icons.shield_outlined),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext ctx) => AlertDialog(
                title: const Row(
                  children: <Widget>[
                    Icon(Icons.verified_user_outlined),
                    SizedBox(width: 8),
                    Text('Sécurité du salon'),
                  ],
                ),
                content: const Text(
                  'Ce salon utilise un protocole Zero-Knowledge basé sur X25519 (Curve25519) et ChaCha20-Poly1305. '
                  'Les clés privées ne quittent jamais votre appareil et le serveur Supabase ne stocke que des données illisibles.',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Fermer'),
                  ),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.vpn_key_rounded, size: 16),
                    label: const Text('Ma phrase secrète'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      unawaited(E2eePassphraseBottomSheet.show(context));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
