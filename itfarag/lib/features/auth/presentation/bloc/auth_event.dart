import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoadAuthEvent extends AuthEvent {
  final String id;

  const LoadAuthEvent(this.id);

  @override
  List<Object?> get props => [id];
}
