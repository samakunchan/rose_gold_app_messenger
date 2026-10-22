import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/invitations_list.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SliversReceivedInvitation extends SignalWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: .all(AppSpacing.spaceMd.value),
      sliver: const SliverToBoxAdapter(
        child: InvitationsList(),
      ),
    );
  }
}
