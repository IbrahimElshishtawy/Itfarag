import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/shorts_entity.dart';

abstract class ShortsRepository {
  Future<Either<Failure, ShortsEntity>> getShortsData(String id);
}
