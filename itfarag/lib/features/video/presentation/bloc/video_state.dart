import 'package:equatable/equatable.dart';
import '../../domain/entities/video_entity.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final VideoEntity entity;

  const VideoLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class VideoError extends VideoState {
  final String message;

  const VideoError(this.message);

  @override
  List<Object?> get props => [message];
}
