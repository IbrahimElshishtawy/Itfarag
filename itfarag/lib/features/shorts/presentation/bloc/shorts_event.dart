import 'package:equatable/equatable.dart';

abstract class ShortsEvent extends Equatable {
  const ShortsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShortsEvent extends ShortsEvent {
  final String id;

  const LoadShortsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
