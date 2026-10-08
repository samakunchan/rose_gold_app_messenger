import 'dart:convert';

import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/datasources/auth_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/datasources/cache_data_source.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/models/user_metadata_model.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  new({required this.remoteDataSource, required this.cacheDataSource});

  final AuthRemoteDataSource remoteDataSource;
  final CacheDataSource cacheDataSource;

  @override
  Future<Either<Failure, AuthSessionEntity>> signIn({required SignInParams params}) async {
    try {
      /// Remember me
      if (params.rememberMe) {
        await cacheDataSource.savedCredentials(credentials: jsonEncode(<String, dynamic>{'email': params.email, 'password': params.password}));
      } else {
        await cacheDataSource.deleteCredentials();
      }

      /// Sign in
      final AuthResponse sessionModel = await remoteDataSource.signIn(email: params.email, password: params.password);
      final User? user = sessionModel.user;
      if (user == null) {
        return const Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: 'Session not found'));
      }
      final UserMetadataModel userMetadataModel = UserMetadataModel.fromJson(user.userMetadata ?? <String, dynamic>{});

      final AuthSessionEntity userEntity = AuthSessionEntity(
        id: user.id,
        email: user.email ?? '',
        phoneNumber: user.phone,
        userMetadataEntity: userMetadataModel.toEntity(),
        username: userMetadataModel.username,
        createdAt: user.createdAt,
        role: user.role,
        invitedAt: user.invitedAt,
        emailConfirmedAt: user.emailConfirmedAt,
      );

      return Right<Failure, AuthSessionEntity>(userEntity);
    } on AuthApiException catch (e) {
      return Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, AuthSessionEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await remoteDataSource.signOut();

      return const Right<Failure, bool>(true);
    } on Failure catch (e) {
      return Left<Failure, bool>(e);
    } on Object catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthSessionEntity>> signUpWithEmail({required SignUpWithEmailParams params}) async {
    try {
      final AuthResponse response = await remoteDataSource.signUp(email: params.email, password: params.password, data: params.data);

      final User? user = response.user;
      if (user == null) {
        return const Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: 'Session not found'));
      }
      final UserMetadataModel userMetadataModel = UserMetadataModel.fromJson(user.userMetadata ?? <String, dynamic>{});

      final AuthSessionEntity userEntity = AuthSessionEntity(
        id: user.id,
        email: user.email ?? '',
        phoneNumber: user.phone,
        userMetadataEntity: userMetadataModel.toEntity(),
        username: userMetadataModel.username,
        createdAt: user.createdAt,
        role: user.role,
        invitedAt: user.invitedAt,
        emailConfirmedAt: user.emailConfirmedAt,
      );
      return Right<Failure, AuthSessionEntity>(userEntity);
    } on AuthApiException catch (e) {
      return Left<Failure, AuthSessionEntity>(RegistrationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, AuthSessionEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthSessionEntity>> signUpWithPhone({required SignUpWithPhoneParams params}) async {
    try {
      final Map<String, dynamic> data = params.username.isNotEmpty
          ? <String, dynamic>{'target_app': 'app_messenger', 'username': params.username}
          : <String, dynamic>{'target_app': 'app_messenger'};
      final AuthResponse response = await remoteDataSource.signUp(email: params.phoneNumber, password: params.password, data: data);

      final User? user = response.user;
      if (user == null) {
        return const Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: 'Session not found'));
      }
      final UserMetadataModel userMetadataModel = UserMetadataModel.fromJson(user.userMetadata ?? <String, dynamic>{});
      final AuthSessionEntity userEntity = AuthSessionEntity(
        id: user.id,
        email: user.email ?? '',
        phoneNumber: user.phone,
        userMetadataEntity: userMetadataModel.toEntity(),
        username: userMetadataModel.username,
        createdAt: user.createdAt,
        role: user.role,
        invitedAt: user.invitedAt,
        emailConfirmedAt: user.emailConfirmedAt,
      );
      return Right<Failure, AuthSessionEntity>(userEntity);
      // return Right<Failure, AuthResponse>(response);
    } on AuthApiException catch (e) {
      return Left<Failure, AuthSessionEntity>(RegistrationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, AuthSessionEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword({required ForgotPasswordParams params}) async {
    try {
      await remoteDataSource.forgotPassword(email: params.email, redirectTo: params.redirectTo);

      return const Right<Failure, bool>(true);
    } on AuthApiException catch (e) {
      if (e.message.contains('you can only request this after')) {
        return const Left<Failure, bool>(DoNotSpamFailure());
      }
      return Left<Failure, bool>(AuthenticationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();

      return const Right<Failure, bool>(true);
    } on AuthApiException catch (e) {
      return Left<Failure, bool>(AuthenticationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthSessionEntity>> changePassword({required ChangePasswordParams params}) async {
    try {
      final UserResponse userResponse = await remoteDataSource.changePassword(
        email: params.email,
        password: params.password,
        token: params.token,
      );

      final User? user = userResponse.user;
      if (user == null) {
        return const Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: 'Session not found'));
      }
      final UserMetadataModel userMetadataModel = UserMetadataModel.fromJson(user.userMetadata ?? <String, dynamic>{});
      final AuthSessionEntity userEntity = AuthSessionEntity(
        id: user.id,
        email: user.email ?? '',
        phoneNumber: user.phone,
        userMetadataEntity: userMetadataModel.toEntity(),
        username: userMetadataModel.username,
        createdAt: user.createdAt,
        role: user.role,
        invitedAt: user.invitedAt,
        emailConfirmedAt: user.emailConfirmedAt,
      );

      return Right<Failure, AuthSessionEntity>(userEntity);
    } on AuthApiException catch (e) {
      return Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, AuthSessionEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthSessionEntity>> getSession() async {
    try {
      final Session? session = await remoteDataSource.getSession();
      if (session == null) {
        return const Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: 'Session not found'));
      }
      // Mapping Supabase User -> UserEntity
      final User user = session.user;
      final UserMetadataModel userMetadataModel = UserMetadataModel.fromJson(user.userMetadata ?? <String, dynamic>{});
      final AuthSessionEntity userEntity = AuthSessionEntity(
        id: user.id,
        email: user.email,
        phoneNumber: user.phone,
        userMetadataEntity: userMetadataModel.toEntity(),
        username: userMetadataModel.username,
        createdAt: user.createdAt,
        role: user.role,
        invitedAt: user.invitedAt,
        emailConfirmedAt: user.emailConfirmedAt,
        lastSignInAt: user.lastSignInAt,
      );

      return Right<Failure, AuthSessionEntity>(userEntity);
    } on AuthApiException catch (e) {
      return Left<Failure, AuthSessionEntity>(AuthenticationFailure(message: e.message));
    } on Object catch (e) {
      return Left<Failure, AuthSessionEntity>(ServerFailure(message: e.toString()));
    }
  }
}
