import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:signals_flutter/signals_flutter.dart';

const String _kAssetLogo = 'assets/common/logo.png';

class RoomsAppBar extends SignalWidget implements PreferredSizeWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final FeedBackStore feedbackStore = kGetIt<FeedBackStore>();

    return AppBar(
      centerTitle: true,
      title: Text(
        'SALONS',
        style: theme.textTheme.displayMedium?.copyWith(letterSpacing: 2, fontWeight: .w300, color: theme.colorScheme.primary),
      ),
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: .all(AppSpacing.spaceSm.value),
        child: Image.asset(_kAssetLogo, fit: .contain),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(20, 55);
}
