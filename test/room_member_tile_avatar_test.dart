import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_member_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/user_presence_item.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_member_tile.dart';

void main() {
  testWidgets('RoomMemberTile passes avatarUrl to MonogramUser', (WidgetTester tester) async {
    const RoomMemberEntity entity = RoomMemberEntity(
      roomId: 'room-1',
      userId: 'user-1',
      role: 'member',
      username: 'Alice',
      avatarUrl: 'https://example.com/alice.png',
      id: '',
      joinedAt: '',
    );
    final RoomMemberViewModel viewModel = RoomMemberViewModel(entity);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: RoomMemberTile(member: viewModel, isOnline: true)),
      ),
    );

    expect(find.byType(MonogramUser), findsOneWidget);
    final MonogramUser monogramUser = tester.widget<MonogramUser>(find.byType(MonogramUser));
    expect(monogramUser.username, equals('Alice'));
    expect(monogramUser.avatarUrl, equals('https://example.com/alice.png'));
    expect(monogramUser.isOnline, isTrue);
  });

  testWidgets('UserPresenceItem passes avatarUrl to MonogramUser', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UserPresenceItem(initial: 'B', displayName: 'Bob', avatarUrl: 'https://example.com/bob.png', isOnline: true),
        ),
      ),
    );

    expect(find.byType(MonogramUser), findsOneWidget);
    final MonogramUser monogramUser = tester.widget<MonogramUser>(find.byType(MonogramUser));
    expect(monogramUser.username, equals('Bob'));
    expect(monogramUser.avatarUrl, equals('https://example.com/bob.png'));
    expect(monogramUser.isOnline, isTrue);
  });
}
