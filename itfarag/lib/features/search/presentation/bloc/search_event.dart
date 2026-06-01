import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class LoadSearchEvent extends SearchEvent {
  final String id;

  const LoadSearchEvent(this.id);

  @override
  List<Object?> get props => [id];
}
