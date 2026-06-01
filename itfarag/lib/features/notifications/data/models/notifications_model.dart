import '../../domain/entities/notifications_entity.dart';

class NotificationsModel extends NotificationsEntity {
  const NotificationsModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
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
