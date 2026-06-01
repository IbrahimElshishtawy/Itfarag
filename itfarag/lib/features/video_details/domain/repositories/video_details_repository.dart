import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/video_details_entity.dart';

abstract class VideoDetailsRepository {
  Future<Either<Failure, VideoDetailsEntity>> getVideoDetailsData(String id);
}
