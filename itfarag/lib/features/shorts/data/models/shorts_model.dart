import '../../domain/entities/shorts_entity.dart';

class ShortsModel extends ShortsEntity {
  const ShortsModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory ShortsModel.fromJson(Map<String, dynamic> json) {
    return ShortsModel(
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
