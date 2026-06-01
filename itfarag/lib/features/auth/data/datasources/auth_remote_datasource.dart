import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> fetchAuthFromApi(String id);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthModel> fetchAuthFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return AuthModel(id: id, name: 'Premium Auth Data');
  }
}
