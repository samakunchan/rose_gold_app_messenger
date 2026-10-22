import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/show_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_invitations_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/user_profile_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/found_users_results.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:signals_flutter/signals_flutter.dart';

class RoomInviteMemberSection extends StatefulWidget {
  const new({required this.roomId, required this.currentMemberIds, required this.currentUserId, super.key});

  final String roomId;
  final List<String> currentMemberIds;
  final String? currentUserId;

  @override
  State<RoomInviteMemberSection> createState() => _RoomInviteMemberSectionState();
}

class _RoomInviteMemberSectionState extends State<RoomInviteMemberSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch() async {
    final String query = _searchController.text.trim();
    if (query.isEmpty) return;

    final RoomInvitationsSignals roomInvitationsSignals = kGetIt<RoomInvitationsSignals>();
    await roomInvitationsSignals.searchUserByTag(userTag: query);
  }

  Future<void> _handleInvite(UserProfileViewModel user) async {
    final RoomInvitationsSignals roomInvitationsSignals = kGetIt<RoomInvitationsSignals>();
    await roomInvitationsSignals.sendInvitation(roomId: widget.roomId, invitedUserId: user.id);

    if (roomInvitationsSignals.errorInvitation.value != null && mounted) {
      showErrorSheet(
        context: context,
        title: 'Échec de l’envoi',
        message: roomInvitationsSignals.errorInvitation.value!,
        actionLabel: 'Patientez environ 1 minute avant de réessayer.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final RoomInvitationsSignals roomInvitationsSignals = kGetIt<RoomInvitationsSignals>();

    return SignalBuilder(
      builder: (_) {
        final bool isSearching = roomInvitationsSignals.isSearching.value;
        final bool isLoading = roomInvitationsSignals.isLoading.value;
        final String? searchError = roomInvitationsSignals.searchError.value;
        final String? successMessage = roomInvitationsSignals.invitationSuccessMessage.value;
        final UserProfileViewModel? foundUser = roomInvitationsSignals.searchedUser.value;
        final ThemeData theme = Theme.of(context);
        final TextTheme textTheme = theme.textTheme;
        final ColorScheme colorScheme = theme.colorScheme;

        return Card(
          margin: .all(AppSpacing.spaceSm.value),
          child: Padding(
            padding: .all(AppSpacing.spaceSm.value),
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.spaceSm.value,
              children: <Widget>[
                Text('Inviter un membre', style: textTheme.bodyLarge),
                TextField(
                  controller: _searchController,
                  textInputAction: .search,
                  decoration: InputDecoration(
                    hintText: 'Identifiant ou nom (ex: cedric5775)...',
                    prefixIcon: const Icon(Icons.alternate_email),
                    suffixIcon: Row(
                      mainAxisSize: .min,
                      children: <Widget>[
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              roomInvitationsSignals.clearSearch();
                              setState(() {});
                            },
                          ),
                        IconButton(
                          icon: isSearching
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.search),
                          onPressed: isSearching ? null : _handleSearch,
                        ),
                      ],
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _handleSearch(),
                  onChanged: (_) => setState(() {}),
                ),
                if (searchError != null) Text(searchError, style: textTheme.bodyMedium?.copyWith(color: colorScheme.error)),
                if (successMessage != null) Text(successMessage, style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary)),
                if (foundUser != null)
                  FoundUsersResults(
                    foundUser: foundUser,
                    isLoading: isLoading,
                    currentUserId: widget.currentUserId,
                    currentMemberIds: widget.currentMemberIds,
                    onPressed: () => _handleInvite(foundUser),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
