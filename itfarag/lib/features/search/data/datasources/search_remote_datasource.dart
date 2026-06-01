import '../models/search_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchModel> fetchSearchFromApi(String id);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<SearchModel> fetchSearchFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return SearchModel(id: id, name: 'Premium Search Data');
  }
}
