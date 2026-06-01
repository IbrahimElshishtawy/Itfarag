import 'package:equatable/equatable.dart';
import '../../domain/entities/video_details_entity.dart';

abstract class VideoDetailsState extends Equatable {
  const VideoDetailsState();

  @override
  List<Object?> get props => [];
}

class VideoDetailsInitial extends VideoDetailsState {}

class VideoDetailsLoading extends VideoDetailsState {}

class VideoDetailsLoaded extends VideoDetailsState {
  final VideoDetailsEntity entity;

  const VideoDetailsLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class VideoDetailsError extends VideoDetailsState {
  final String message;

  const VideoDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
