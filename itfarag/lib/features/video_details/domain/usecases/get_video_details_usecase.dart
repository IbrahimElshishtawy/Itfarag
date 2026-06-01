import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/video_details_entity.dart';
import '../repositories/video_details_repository.dart';

class GetVideoDetailsUseCase {
  final VideoDetailsRepository repository;

  GetVideoDetailsUseCase(this.repository);

  Future<Either<Failure, VideoDetailsEntity>> call(String id) async {
    return await repository.getVideoDetailsData(id);
  }
}
