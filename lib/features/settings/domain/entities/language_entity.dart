import 'package:equatable/equatable.dart';

class LanguageEntity extends Equatable {
  const new({required this.label, required this.languageCode});
  final String label;
  final String languageCode;
  @override
  List<Object?> get props => <Object?>[label, languageCode];
}
