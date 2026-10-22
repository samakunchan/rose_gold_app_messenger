import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_invitations_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/rooms_app_bar.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/slivers_received_invitation.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/slivers_rooms_available.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/slivers_users_online.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/top_user_identifier.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';

class RoomsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
    // Appelé UNE SEULE FOIS au chargement de l'écran
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    unawaited(kGetIt<RoomsSignals>().getRooms());
    unawaited(kGetIt<RoomMembersSignals>().fetchCoMembers());
    if (authSignals.currentAuthSession.value != null) {
      unawaited(
        kGetIt<RoomInvitationsSignals>().receiveInvitation(invitedUserId: authSignals.currentAuthSession.value!.userId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RoomsAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopUserIdentifier(),

            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliversUsersOnline(),
                  SliversReceivedInvitation(),
                  SliversRoomsAvailable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
