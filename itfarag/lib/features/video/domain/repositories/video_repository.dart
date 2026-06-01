import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Failure, VideoEntity>> getVideoData(String id);
}
