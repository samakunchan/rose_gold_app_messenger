import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/credential_remembered_entity.dart';

class CredentialsSavedViewModel {
  new(CredentialRememberedEntity entity) : _entity = entity;

  final CredentialRememberedEntity _entity;
  CredentialRememberedEntity get entity => _entity;

  String get emailSaved => _entity.email;
  String get passwordSaved => _entity.password;
}
