import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/error/exceptions.dart';
import '../../domain/entities/shorts_entity.dart';
import '../../domain/repositories/shorts_repository.dart';
import '../datasources/shorts_remote_datasource.dart';

class ShortsRepositoryImpl implements ShortsRepository {
  final ShortsRemoteDataSource remoteDataSource;

  ShortsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ShortsEntity>> getShortsData(String id) async {
    try {
      final remoteData = await remoteDataSource.fetchShortsFromApi(id);
      return Right(remoteData);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure('Connection failed.'));
    }
  }
}
