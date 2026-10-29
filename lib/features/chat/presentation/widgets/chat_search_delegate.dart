import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChatSearchDelegate extends SearchDelegate<void> {
  new({required this.roomId}) : super(searchFieldLabel: 'Rechercher un message...');

  final String roomId;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            kGetIt<ChatSignals>().clearSearch();
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        kGetIt<ChatSignals>().clearSearch();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _triggerSearch();
    return _buildResultsList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isNotEmpty) {
      _triggerSearch();
    }
    return _buildResultsList(context);
  }

  void _triggerSearch() {
    unawaited(kGetIt<ChatSignals>().search(query: query, roomId: roomId));
  }

  Widget _buildResultsList(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatSignals chatSignals = kGetIt<ChatSignals>();

    return SignalBuilder(
      builder: (_) {
        final bool isSearching = chatSignals.isSearching.value;
        final List<MessageViewModel> results = chatSignals.searchResults.value;

        if (isSearching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (query.trim().isEmpty) {
          return Center(
            child: Text(
              'Tapez un mot-clé pour chercher dans les messages déchiffrés.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          );
        }

        if (results.isEmpty) {
          return Center(
            child: Text(
              'Aucun message ne correspond à "$query".',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext ctx, int index) {
            final MessageViewModel message = results[index];
            return ChatMessageBubble(message: message);
          },
        );
      },
    );
  }
}
