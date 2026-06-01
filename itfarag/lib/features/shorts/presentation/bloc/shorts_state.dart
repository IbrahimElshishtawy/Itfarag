import 'package:equatable/equatable.dart';
import '../../domain/entities/shorts_entity.dart';

abstract class ShortsState extends Equatable {
  const ShortsState();

  @override
  List<Object?> get props => [];
}

class ShortsInitial extends ShortsState {}

class ShortsLoading extends ShortsState {}

class ShortsLoaded extends ShortsState {
  final ShortsEntity entity;

  const ShortsLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class ShortsError extends ShortsState {
  final String message;

  const ShortsError(this.message);

  @override
  List<Object?> get props => [message];
}
