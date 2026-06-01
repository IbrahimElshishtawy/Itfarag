import '../models/video_details_model.dart';

abstract class VideoDetailsRemoteDataSource {
  Future<VideoDetailsModel> fetchVideoDetailsFromApi(String id);
}

class VideoDetailsRemoteDataSourceImpl implements VideoDetailsRemoteDataSource {
  @override
  Future<VideoDetailsModel> fetchVideoDetailsFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return VideoDetailsModel(id: id, name: 'Premium VideoDetails Data');
  }
}
