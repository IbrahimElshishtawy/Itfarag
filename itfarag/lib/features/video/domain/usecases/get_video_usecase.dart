import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class GetVideoUseCase {
  final VideoRepository repository;

  GetVideoUseCase(this.repository);

  Future<Either<Failure, VideoEntity>> call(String id) async {
    return await repository.getVideoData(id);
  }
}
