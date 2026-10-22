import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  const new({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.avatarUrl,
    this.description,
  });

  final String id;
  final String name;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final String? avatarUrl;
  final String? description;

  @override
  List<Object?> get props => <Object?>[id, name, createdBy, createdAt, updatedAt];
}
