import '../models/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<VideoModel> fetchVideoFromApi(String id);
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  @override
  Future<VideoModel> fetchVideoFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return VideoModel(id: id, name: 'Premium Video Data');
  }
}
