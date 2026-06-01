import 'package:equatable/equatable.dart';

abstract class VideoDetailsEvent extends Equatable {
  const VideoDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadVideoDetailsEvent extends VideoDetailsEvent {
  final String id;

  const LoadVideoDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
