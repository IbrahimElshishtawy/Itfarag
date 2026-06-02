import '../../domain/entities/favorites_entity.dart';

class FavoritesModel extends FavoritesEntity {
  const FavoritesModel({
    required super.id,
    required super.name,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
