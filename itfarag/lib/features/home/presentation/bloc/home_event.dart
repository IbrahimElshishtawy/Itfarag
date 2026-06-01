import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeEvent extends HomeEvent {
  final String id;

  const LoadHomeEvent(this.id);

  @override
  List<Object?> get props => [id];
}
