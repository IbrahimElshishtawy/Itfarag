import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeEntity>> getHomeData(String id);
}
