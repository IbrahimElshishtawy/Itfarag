import '../../domain/entities/live_stream_entity.dart';

class LiveStreamModel extends LiveStreamEntity {
  const LiveStreamModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) {
    return LiveStreamModel(
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
