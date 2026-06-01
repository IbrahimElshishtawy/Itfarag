import 'package:equatable/equatable.dart';

class FavoritesEntity extends Equatable {
  final String id;
  final String name;

  const FavoritesEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
