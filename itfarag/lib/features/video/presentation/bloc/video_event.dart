import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class LoadVideoEvent extends VideoEvent {
  final String id;

  const LoadVideoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
