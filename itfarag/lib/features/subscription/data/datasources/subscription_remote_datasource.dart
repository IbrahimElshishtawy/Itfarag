import '../models/subscription_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionModel> fetchSubscriptionFromApi(String id);
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  @override
  Future<SubscriptionModel> fetchSubscriptionFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return SubscriptionModel(id: id, name: 'Premium Subscription Data');
  }
}
