import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_context_menu_action_button.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChatMessageContextMenu extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatSignals chatSignals = kGetIt<ChatSignals>();
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;

    return SignalBuilder(
      builder: (_) {
        final MessageViewModel? selectedMessage = chatSignals.selectedMessage;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: selectedMessage == null
              ? const SizedBox.shrink()
              : Stack(
                  key: ValueKey<String>(selectedMessage.id),
                  children: <Widget>[
                    /// Fondu noir à l'arrière (ferme le menu au tap)
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: .opaque,
                        onTap: chatSignals.clearSelectedMessage,
                        child: DecoratedBox(
                          decoration: chatTheme.contextMenuBackdropDecoration,
                        ),
                      ),
                    ),

                    /// Menu contextuel sur le côté droit de l'écran
                    Align(
                      alignment: .centerRight,
                      child: Padding(
                        padding: .only(right: AppSpacing.spaceSm.value),
                        child: Container(
                          width: 210,
                          padding: .symmetric(
                            horizontal: AppSpacing.spaceSm.value,
                            vertical: AppSpacing.spaceSm.value,
                          ),
                          decoration: chatTheme.contextMenuDecoration,
                          child: Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .stretch,
                            spacing: AppSpacing.space2xs.value,
                            children: <Widget>[
                              ChatContextMenuActionButton(
                                icon: Icons.reply_rounded,
                                label: 'Répondre',
                                onTap: () {},
                              ),
                              ChatContextMenuActionButton(
                                icon: Icons.push_pin_outlined,
                                label: 'Épingler',
                                onTap: () {},
                              ),
                              ChatContextMenuActionButton(
                                icon: Icons.flag_outlined,
                                label: 'Signaler',
                                isDestructive: true,
                                onTap: () {},
                              ),
                              const Divider(height: 8),
                              ChatContextMenuActionButton(
                                icon: Icons.close_rounded,
                                label: 'Annuler',
                                onTap: chatSignals.clearSelectedMessage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
