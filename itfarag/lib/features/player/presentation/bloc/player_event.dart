import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class LoadPlayerEvent extends PlayerEvent {
  final String id;

  const LoadPlayerEvent(this.id);

  @override
  List<Object?> get props => [id];
}
