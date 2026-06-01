import '../models/live_stream_model.dart';

abstract class LiveStreamRemoteDataSource {
  Future<LiveStreamModel> fetchLiveStreamFromApi(String id);
}

class LiveStreamRemoteDataSourceImpl implements LiveStreamRemoteDataSource {
  @override
  Future<LiveStreamModel> fetchLiveStreamFromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return LiveStreamModel(id: id, name: 'Premium LiveStream Data');
  }
}
