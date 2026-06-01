import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/live_stream_entity.dart';
import '../repositories/live_stream_repository.dart';

class GetLiveStreamUseCase {
  final LiveStreamRepository repository;

  GetLiveStreamUseCase(this.repository);

  Future<Either<Failure, LiveStreamEntity>> call(String id) async {
    return await repository.getLiveStreamData(id);
  }
}
