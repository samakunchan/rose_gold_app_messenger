import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/static_radius.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TopUserIdentifier extends SignalWidget {
  const new({this.authSignals, super.key});
  final AuthSignals? authSignals;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final AuthSignals signals = authSignals ?? kGetIt<AuthSignals>();

    final String username = signals.userConnectedName.value ?? 'Utilisateur';
    final String? userTag = signals.userConnectedTag.value;

    return Container(
      margin: .symmetric(horizontal: AppSpacing.spaceBase.value, vertical: AppSpacing.spaceSm.value),
      padding: .symmetric(horizontal: AppSpacing.spaceBase.value, vertical: AppSpacing.spaceMd.value),
      decoration: roomTheme.userInfoCardDecoration,
      child: Row(
        children: <Widget>[
          /// Monogramme avec dégradé Rose Gold & bague dorée
          MonogramUser(username: username),
          const SizedBox(width: 14),

          /// Informations utilisateur
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: <Widget>[
                Text(
                  'Bienvenue,',
                  style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 0.5),
                ),
                Text(
                  username,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: .w700, color: theme.colorScheme.primary),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ),

          /// Capsule de l'identifiant cliquable pour copier
          if (userTag != null && userTag.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: .all(.circular(AppRadius.full.value)),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: userTag));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Identifiant copié !'), duration: Duration(seconds: 2), behavior: .floating),
                    );
                  }
                },
                child: Ink(
                  padding: const .symmetric(horizontal: 10, vertical: 6),
                  decoration: roomTheme.badgePrimaryDecoration,
                  child: Row(
                    mainAxisSize: .min,
                    spacing: AppSpacing.spaceSm.value,
                    children: <Widget>[
                      Text(
                        '@$userTag',
                        style: theme.textTheme.labelMedium?.copyWith(fontWeight: .w600, color: roomTheme.primaryTextColor),
                      ),
                      Icon(Icons.copy_rounded, size: 13, color: roomTheme.primaryTextColor),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
