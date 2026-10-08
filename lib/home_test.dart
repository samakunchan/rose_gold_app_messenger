import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
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
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
