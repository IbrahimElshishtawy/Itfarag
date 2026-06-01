import 'package:equatable/equatable.dart';
import '../../domain/entities/player_entity.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final PlayerEntity entity;

  const PlayerLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class PlayerError extends PlayerState {
  final String message;

  const PlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
