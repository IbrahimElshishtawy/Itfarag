import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/favorites_entity.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, FavoritesEntity>> call(String id) async {
    return await repository.getFavoritesData(id);
  }
}
