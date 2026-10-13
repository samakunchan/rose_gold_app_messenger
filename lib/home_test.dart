import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/signals/user_presence_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeTest extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: .center,
        children: <Widget>[
          SignalBuilder(
            builder: (_) {
              final AuthSignals authSignals = kGetIt<AuthSignals>();
              final UserPresenceSignals presenceSignals = kGetIt<UserPresenceSignals>();

              return Column(
                mainAxisAlignment: .center,
                spacing: AppSpacing.spaceSm.value,
                children: <Widget>[
                  if (authSignals.accountCreatedAt.value != null)
                    Column(
                      children: <Widget>[
                        Text('Bienvenue : ${authSignals.userConnectedName}'),
                        Text('Date de création du compte : ${authSignals.accountCreatedAt}'),
                      ],
                    )
                  else
                    const SizedBox(),
                  ElevatedButton(
                    onPressed: authSignals.deleteAppMessengerAccount,
                    child: const Text('Test delete account'),
                  ),
                  ElevatedButton(
                    onPressed: authSignals.signOut,
                    child: const Text('Logout'),
                  ),
                  const SizedBox(height: 30),
                  Badge(
                    isLabelVisible: presenceSignals.isConnectedToGlobalChannel.value,
                    backgroundColor: Colors.green,
                    label: presenceSignals.isConnectedToGlobalChannel.value ? const Text('Online') : const SizedBox(),
                    child: ElevatedButton(
                      onPressed: () => presenceSignals.joinGlobalChannel(
                        userId: authSignals.currentAuthSession.value!.userId,
                        username: authSignals.currentAuthSession.value!.username,
                        device: Platform.operatingSystem,
                      ),
                      child: const Text('Join global channel'),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: presenceSignals.leaveGlobalChannel,
                    child: const Text('Quit global channel'),
                  ),
                  const SizedBox(height: 30),
                  if (presenceSignals.onlineUsers.value.isNotEmpty)
                    Column(
                      children: List<Widget>.generate(
                        presenceSignals.onlineUsers.value.length,
                        (int index) =>
                            Text('${presenceSignals.onlineUsers.value[index].username} ${presenceSignals.onlineUsers.value[index].device}'),
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
