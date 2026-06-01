import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {
  final String id;

  const LoadFavoritesEvent(this.id);

  @override
  List<Object?> get props => [id];
}
