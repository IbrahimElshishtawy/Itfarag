import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final String id;

  const LoadProfileEvent(this.id);

  @override
  List<Object?> get props => [id];
}
