import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/user_profile_view_model.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';

class FoundUsersResults extends StatelessWidget {
  const new({
    required this.foundUser,
    required this.isLoading,
    required this.currentUserId,
    required this.currentMemberIds,
    this.onPressed,
    super.key,
  });
  final UserProfileViewModel foundUser;
  final bool isLoading;
  final String? currentUserId;
  final List<String> currentMemberIds;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Container(
      padding: .all(AppSpacing.spaceSm.value),
      decoration: BoxDecoration(
        border: .all(color: Colors.grey.shade400),
        borderRadius: .circular(8),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Row(
            spacing: AppSpacing.spaceMd.value,
            children: <Widget>[
              CircleAvatar(
                child: Text(foundUser.username.isNotEmpty ? foundUser.username[0].toUpperCase() : '?'),
              ),
              Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  Text(foundUser.username, style: textTheme.titleMedium),
                  Text('@${foundUser.userTag}', style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
          if (foundUser.id == currentUserId)
            Text('C‘est vous-même', style: textTheme.bodySmall?.copyWith(fontStyle: .italic))
          else if (currentMemberIds.contains(foundUser.id))
            Text('Déjà membre', style: textTheme.bodySmall?.copyWith(fontStyle: .italic))
          else
            ElevatedButton.icon(
              icon: isLoading
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.person_add, size: 18),
              label: const Text('Inviter'),
              onPressed: isLoading ? null : onPressed,
            ),
        ],
      ),
    );
  }
}
