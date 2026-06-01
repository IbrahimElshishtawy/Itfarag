import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/favorites_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, FavoritesEntity>> getFavoritesData(String id);
}
