import '../models/favorites_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<FavoritesModel> fetchFavoritesFromApi(String id);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  @override
  Future<FavoritesModel> fetchFavoritesFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return FavoritesModel(id: id, name: 'Premium Favorites Data');
  }
}
