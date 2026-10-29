import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_empty_view.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/e2ee_security_banner.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatMessagesList extends StatelessWidget {
  const new({required this.messages, required this.scrollController, super.key});

  final List<MessageViewModel> messages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Column(
        children: <Widget>[
          E2eeSecurityBanner(),
          Expanded(child: ChatEmptyView()),
        ],
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: .only(top: AppSpacing.spaceSm.value, bottom: AppSpacing.spaceMd.value),
      itemCount: messages.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == messages.length) {
          return const E2eeSecurityBanner();
        }

        final MessageViewModel message = messages[messages.length - 1 - index];
        return ChatMessageBubble(key: ValueKey<String>(message.id), message: message);
      },
    );
  }
}
