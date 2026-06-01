import 'package:equatable/equatable.dart';

abstract class LiveStreamEvent extends Equatable {
  const LiveStreamEvent();

  @override
  List<Object?> get props => [];
}

class LoadLiveStreamEvent extends LiveStreamEvent {
  final String id;

  const LoadLiveStreamEvent(this.id);

  @override
  List<Object?> get props => [id];
}
