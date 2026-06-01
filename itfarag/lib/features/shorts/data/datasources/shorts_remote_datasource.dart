import '../models/shorts_model.dart';

abstract class ShortsRemoteDataSource {
  Future<ShortsModel> fetchShortsFromApi(String id);
}

class ShortsRemoteDataSourceImpl implements ShortsRemoteDataSource {
  @override
  Future<ShortsModel> fetchShortsFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return ShortsModel(id: id, name: 'Premium Shorts Data');
  }
}
