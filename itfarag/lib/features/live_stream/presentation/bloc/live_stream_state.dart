import 'package:equatable/equatable.dart';
import '../../domain/entities/live_stream_entity.dart';

abstract class LiveStreamState extends Equatable {
  const LiveStreamState();

  @override
  List<Object?> get props => [];
}

class LiveStreamInitial extends LiveStreamState {}

class LiveStreamLoading extends LiveStreamState {}

class LiveStreamLoaded extends LiveStreamState {
  final LiveStreamEntity entity;

  const LiveStreamLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class LiveStreamError extends LiveStreamState {
  final String message;

  const LiveStreamError(this.message);

  @override
  List<Object?> get props => [message];
}
