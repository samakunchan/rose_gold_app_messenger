import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_message_context_menu.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_messages_list.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/signals/moderation_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChatScreen extends StatefulWidget {
  const new({required this.roomId, required this.roomName, this.peerPublicKeyBase64, super.key});

  final String roomId;
  final String roomName;
  final String? peerPublicKeyBase64;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late final ChatSignals _chatSignals;

  @override
  void initState() {
    super.initState();
    _chatSignals = kGetIt<ChatSignals>();
    unawaited(kGetIt<ModerationSignals>().fetchBlockedUsers());
    unawaited(_chatSignals.initializeKeys());
    _chatSignals.subscribeToRoom(roomId: widget.roomId, peerPublicKeyBase64: widget.peerPublicKeyBase64);
  }

  @override
  void dispose() {
    unawaited(_chatSignals.dispose());
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients && _scrollController.offset > 0) {
      _scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(roomId: widget.roomId, roomName: widget.roomName),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: SignalBuilder(
                    builder: (_) {
                      final bool isLoading = _chatSignals.isLoading.value;
                      final List<MessageViewModel> messages = _chatSignals.messages.value;

                      if (isLoading && messages.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ChatMessagesList(messages: messages, scrollController: _scrollController);
                    },
                  ),
                ),
                SignalBuilder(
                  builder: (_) {
                    final String? typingText = _chatSignals.typingIndicatorText;
                    if (typingText == null) {
                      return const SizedBox.shrink();
                    }
                    final ThemeData theme = Theme.of(context);
                    return Container(
                      width: .infinity,
                      padding: .symmetric(
                        horizontal: AppSpacing.spaceMd.value,
                        vertical: AppSpacing.spaceXs.value,
                      ),
                      child: Row(
                        spacing: AppSpacing.spaceXs.value,
                        children: <Widget>[
                          Icon(
                            Icons.edit_note_rounded,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          Expanded(
                            child: Text(
                              typingText,
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontStyle: .italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ChatInputField(
                  roomId: widget.roomId,
                  peerPublicKeyBase64: widget.peerPublicKeyBase64,
                  onMessageSent: _scrollToBottom,
                ),
              ],
            ),
            const ChatMessageContextMenu(),
          ],
        ),
      ),
    );
  }
}
