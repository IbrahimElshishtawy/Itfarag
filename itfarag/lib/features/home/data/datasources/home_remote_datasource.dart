import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> fetchHomeFromApi(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeModel> fetchHomeFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return HomeModel(id: id, name: 'Premium Home Data');
  }
}
