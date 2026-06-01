import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/error/exceptions.dart';
import '../../domain/entities/favorites_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FavoritesEntity>> getFavoritesData(String id) async {
    try {
      final remoteData = await remoteDataSource.fetchFavoritesFromApi(id);
      return Right(remoteData);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure('Connection failed.'));
    }
  }
}
