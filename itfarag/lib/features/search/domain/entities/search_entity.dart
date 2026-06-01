import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  final String id;
  final String name;

  const SearchEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
