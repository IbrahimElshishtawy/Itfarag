import '../../domain/entities/video_details_entity.dart';

class VideoDetailsModel extends VideoDetailsEntity {
  const VideoDetailsModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) {
    return VideoDetailsModel(
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
