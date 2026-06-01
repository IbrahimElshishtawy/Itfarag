import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final String id;
  final String name;

  const SettingsEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
