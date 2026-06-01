import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/error/exceptions.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/repositories/player_repository.dart';
import '../datasources/player_remote_datasource.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerRemoteDataSource remoteDataSource;

  PlayerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PlayerEntity>> getPlayerData(String id) async {
    try {
      final remoteData = await remoteDataSource.fetchPlayerFromApi(id);
      return Right(remoteData);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure('Connection failed.'));
    }
  }
}
