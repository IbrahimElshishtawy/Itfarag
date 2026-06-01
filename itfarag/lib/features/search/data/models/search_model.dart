import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  const SearchModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
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
