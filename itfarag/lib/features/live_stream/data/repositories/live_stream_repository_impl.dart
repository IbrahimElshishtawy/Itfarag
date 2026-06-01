import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/error/exceptions.dart';
import '../../domain/entities/live_stream_entity.dart';
import '../../domain/repositories/live_stream_repository.dart';
import '../datasources/live_stream_remote_datasource.dart';

class LiveStreamRepositoryImpl implements LiveStreamRepository {
  final LiveStreamRemoteDataSource remoteDataSource;

  LiveStreamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LiveStreamEntity>> getLiveStreamData(String id) async {
    try {
      final remoteData = await remoteDataSource.fetchLiveStreamFromApi(id);
      return Right(remoteData);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure('Connection failed.'));
    }
  }
}
