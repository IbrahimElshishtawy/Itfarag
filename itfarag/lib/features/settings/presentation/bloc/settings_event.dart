import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {
  final String id;

  const LoadSettingsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
