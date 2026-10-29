import 'package:equatable/equatable.dart';

class UserPublicKeyEntity extends Equatable {
  const new({
    required this.userId,
    required this.publicKey,
    required this.keyFingerprint,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final String publicKey;
  final String keyFingerprint;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object?> get props => <Object?>[
    userId,
    publicKey,
    keyFingerprint,
    createdAt,
    updatedAt,
  ];
}
