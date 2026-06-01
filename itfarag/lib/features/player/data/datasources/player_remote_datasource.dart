import '../models/player_model.dart';

abstract class PlayerRemoteDataSource {
  Future<PlayerModel> fetchPlayerFromApi(String id);
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  @override
  Future<PlayerModel> fetchPlayerFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return PlayerModel(id: id, name: 'Premium Player Data');
  }
}
