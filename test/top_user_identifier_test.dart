import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/profile/data/models/profile_model.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/repositories/profile_repository.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/watch_profiles_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/signals/profile_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/top_user_identifier.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';

class StubProfileRepository implements ProfileRepository {
  ProfileEntity? stubEntity;

  @override
  Future<Either<Failure, ProfileEntity?>> getProfile({required String userId}) async {
    return Right<Failure, ProfileEntity?>(stubEntity);
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({required String userId, String? username, String? avatarUrl, String? phone}) async {
    return Right<Failure, ProfileEntity>(stubEntity!);
  }

  @override
  Stream<ProfileEntity> watchProfiles() => const Stream<ProfileEntity>.empty();
}

void main() {
  testWidgets('TopUserIdentifier renders username and userTag from ProfileSignals', (WidgetTester tester) async {
    final ProfileEntity entity = ProfileModel(
      id: 'user-456',
      username: 'Bob Dylan',
      userTag: 'bob456',
      avatarUrl: 'https://example.com/bob.jpg',
    ).toEntity();

    final StubProfileRepository repo = StubProfileRepository()..stubEntity = entity;
    final ProfileSignals profileSignals = ProfileSignals(
      getProfileUseCase: GetProfileUseCase(repository: repo),
      updateProfileUseCase: UpdateProfileUseCase(repository: repo),
      watchProfilesUseCase: WatchProfilesUseCase(repo),
    );

    await profileSignals.fetchProfile(userId: 'user-456');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: TopUserIdentifier(profileSignals: profileSignals)),
      ),
    );

    expect(find.text('Bienvenue,'), findsOneWidget);
    expect(find.text('Bob Dylan'), findsOneWidget);
    expect(find.text('@bob456'), findsOneWidget);
    expect(find.byType(MonogramUser), findsOneWidget);

    final MonogramUser monogramUser = tester.widget<MonogramUser>(find.byType(MonogramUser));
    expect(monogramUser.username, equals('Bob Dylan'));
    expect(monogramUser.avatarUrl, equals('https://example.com/bob.jpg'));
  });
}
