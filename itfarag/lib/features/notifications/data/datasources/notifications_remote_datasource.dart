import '../models/notifications_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<NotificationsModel> fetchNotificationsFromApi(String id);
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  @override
  Future<NotificationsModel> fetchNotificationsFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return NotificationsModel(id: id, name: 'Premium Notifications Data');
  }
}
