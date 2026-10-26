import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signIn({required String email, required String password});
  Future<AuthResponse> signUp({required String email, required String password, required Map<String, dynamic> data});
  Future<AuthResponse> signUpWithPhoneNumber({required String phoneNumber, required String password, required Map<String, dynamic> data});
  Future<void> forgotPassword({required String email, required String redirectTo});
  Future<void> signOut();
  Future<void> deleteAccount();

  Future<UserResponse> changePassword({required String email, required String password, String? token});
  Future<UserResponse> updateProfile({String? username, String? avatarUrl, String? phoneNumber});

  Future<Session?> getSession();
  Future<String?> getUserTag({required String userId});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<AuthResponse> signIn({required String email, required String password}) async {
    final AuthResponse res = await client.auth.signInWithPassword(email: email, password: password);

    final Map<String, dynamic>? appAccess = await client.from('user_apps').select().eq('app_name', 'app_messenger').maybeSingle();

    if (appAccess == null) {
      await client.auth.signOut();
      throw const AuthException('Ce compte n‘est pas autorisé sur cette application.');
    }

    return res;
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Future<AuthResponse> signUp({required String email, required String password, required Map<String, dynamic> data}) async {
    final AuthResponse res = await client.auth.signUp(
      email: email,
      password: password,
      data: data,
      emailRedirectTo: 'rosegoldappmessenger://login-callback',
    );

    return res;
  }

  @override
  Future<void> deleteAccount() async {
    await client.rpc<void>('delete_user_account', params: <String, dynamic>{'p_app_name': 'app_messenger'});

    await signOut();
  }

  @override
  Future<void> forgotPassword({required String email, required String redirectTo}) async {
    await client.auth.resetPasswordForEmail(email, redirectTo: redirectTo);
  }

  @override
  Future<UserResponse> changePassword({required String email, required String password, String? token}) async {
    if (token != null && token.trim().isNotEmpty) {
      await client.auth.verifyOTP(
        type: .recovery, // Spécifique à la réinitialisation
        email: email.trim(),
        token: token.trim(),
      );
    }

    final UserResponse updatedUser = await client.auth.updateUser(UserAttributes(password: password));

    await signOut();
    return updatedUser;
  }

  @override
  Future<UserResponse> updateProfile({String? username, String? avatarUrl, String? phoneNumber}) async {
    final User? currentUser = client.auth.currentUser;
    if (currentUser == null) {
      throw const AuthException('Utilisateur non connecté.');
    }

    final Map<String, dynamic> profileUpdates = <String, dynamic>{
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'username': ?username,
      'avatar_url': ?avatarUrl,
      'phone': ?phoneNumber,
    };

    await client.from('profiles').update(profileUpdates).eq('id', currentUser.id);

    final Map<String, dynamic> metadataUpdates = <String, dynamic>{
      'username': ?username,
      'avatar_url': ?avatarUrl,
      'phone_number': ?phoneNumber,
    };

    final UserResponse updatedUser = await client.auth.updateUser(
      UserAttributes(data: metadataUpdates),
    );

    return updatedUser;
  }

  @override
  Future<Session?> getSession() async {
    final Session? session = client.auth.currentSession;

    return session;
  }

  @override
  Future<AuthResponse> signUpWithPhoneNumber({required String phoneNumber, required String password, required Map<String, dynamic> data}) async {
    final AuthResponse res = await client.auth.signUp(email: phoneNumber, password: password, data: data);

    return res;
  }

  @override
  Future<String?> getUserTag({required String userId}) async {
    try {
      final Map<String, dynamic>? profile = await client.from('profiles').select('user_tag').eq('id', userId).maybeSingle();
      return profile?['user_tag'] as String?;
    } on Object catch (_) {
      return null;
    }
  }
}
