import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/profile/data/models/profile_model.dart';
import 'package:rose_gold_app_messenger/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/repositories/profile_repository.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/watch_profiles_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/signals/profile_signals.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/view_models/profile_view_model.dart';

class FakeProfileRemoteDataSource implements ProfileRemoteDataSource {
  ProfileModel? stubProfile;
  final StreamController<ProfileModel> _controller = StreamController<ProfileModel>.broadcast();

  @override
  Future<ProfileModel?> getProfile({required String userId}) async {
    return stubProfile;
  }

  @override
  Future<ProfileModel> updateProfile({required String userId, String? username, String? avatarUrl, String? phone}) async {
    final ProfileModel updated = ProfileModel(
      id: userId,
      username: username ?? stubProfile?.username ?? '',
      userTag: stubProfile?.userTag ?? 'test1234',
      avatarUrl: avatarUrl ?? stubProfile?.avatarUrl,
      phone: phone ?? stubProfile?.phone,
    );
    stubProfile = updated;
    return updated;
  }

  @override
  Stream<ProfileModel> watchProfiles() => _controller.stream;

  void emitRealtimeProfile(ProfileModel model) {
    _controller.add(model);
  }
}

void main() {
  final ProfileModel testModel = ProfileModel(
    id: 'user-123',
    username: 'Alice Smith',
    userTag: 'alice5678',
    avatarUrl: 'https://example.com/avatar.png',
    phone: '+33612345678',
  );

  test('ProfileModel JSON serialization and toEntity mapping', () {
    final Map<String, dynamic> json = testModel.toJson();
    expect(json['id'], equals('user-123'));
    expect(json['username'], equals('Alice Smith'));
    expect(json['user_tag'], equals('alice5678'));
    expect(json['avatar_url'], equals('https://example.com/avatar.png'));

    final ProfileModel fromJsonModel = ProfileModel.fromJson(json);
    expect(fromJsonModel, equals(testModel));

    final ProfileEntity entity = fromJsonModel.toEntity();
    expect(entity.id, equals('user-123'));
    expect(entity.username, equals('Alice Smith'));
    expect(entity.userTag, equals('alice5678'));
    expect(entity.avatarUrl, equals('https://example.com/avatar.png'));
  });

  test('ProfileViewModel properties and initial computation', () {
    final ProfileViewModel viewModel = ProfileViewModel(testModel.toEntity());

    expect(viewModel.id, equals('user-123'));
    expect(viewModel.username, equals('Alice Smith'));
    expect(viewModel.userTag, equals('alice5678'));
    expect(viewModel.displayName, equals('@alice5678'));
    expect(viewModel.avatarUrl, equals('https://example.com/avatar.png'));
    expect(viewModel.hasAvatar, isTrue);
    expect(viewModel.initial, equals('AS'));
  });

  test('ProfileRepositoryImpl and UseCases work together', () async {
    final FakeProfileRemoteDataSource dataSource = FakeProfileRemoteDataSource()..stubProfile = testModel;
    final ProfileRepository repository = ProfileRepositoryImpl(remoteDataSource: dataSource);

    final GetProfileUseCase getUseCase = GetProfileUseCase(repository: repository);
    final Either<Failure, ProfileEntity?> getResult = await getUseCase(userId: 'user-123');
    expect(getResult.isRight, isTrue);
    expect(getResult.getOrNull()?.username, equals('Alice Smith'));

    final UpdateProfileUseCase updateUseCase = UpdateProfileUseCase(repository: repository);
    final Either<Failure, ProfileEntity> updateResult = await updateUseCase(userId: 'user-123', avatarUrl: 'https://example.com/new_avatar.jpg');
    expect(updateResult.isRight, isTrue);
    expect(updateResult.getOrNull()?.avatarUrl, equals('https://example.com/new_avatar.jpg'));
  });

  test('ProfileSignals manages state correctly', () async {
    final FakeProfileRemoteDataSource dataSource = FakeProfileRemoteDataSource()..stubProfile = testModel;
    final ProfileRepository repository = ProfileRepositoryImpl(remoteDataSource: dataSource);
    final ProfileSignals signals = ProfileSignals(
      getProfileUseCase: GetProfileUseCase(repository: repository),
      updateProfileUseCase: UpdateProfileUseCase(repository: repository),
      watchProfilesUseCase: WatchProfilesUseCase(repository),
    );

    expect(signals.currentProfile.value, isNull);

    await signals.fetchProfile(userId: 'user-123');
    expect(signals.currentProfile.value, isNotNull);
    expect(signals.currentProfile.value?.avatarUrl, equals('https://example.com/avatar.png'));

    final bool success = await signals.updateProfile(userId: 'user-123', avatarUrl: 'https://example.com/updated.jpg');
    expect(success, isTrue);
    expect(signals.currentProfile.value?.avatarUrl, equals('https://example.com/updated.jpg'));
  });

  test('ProfileSignals receives realtime profile updates', () async {
    final FakeProfileRemoteDataSource dataSource = FakeProfileRemoteDataSource()..stubProfile = testModel;
    final ProfileRepository repository = ProfileRepositoryImpl(remoteDataSource: dataSource);
    final ProfileSignals signals = ProfileSignals(
      getProfileUseCase: GetProfileUseCase(repository: repository),
      updateProfileUseCase: UpdateProfileUseCase(repository: repository),
      watchProfilesUseCase: WatchProfilesUseCase(repository),
    );

    await signals.fetchProfile(userId: 'user-123');
    signals.startListeningRealtime();

    dataSource.emitRealtimeProfile(testModel.copyWith(username: 'Alice Realtime', avatarUrl: 'https://example.com/alice_realtime.png'));

    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(signals.currentProfile.value?.username, equals('Alice Realtime'));
    expect(signals.currentProfile.value?.avatarUrl, equals('https://example.com/alice_realtime.png'));

    signals.stopListeningRealtime();
  });
}
