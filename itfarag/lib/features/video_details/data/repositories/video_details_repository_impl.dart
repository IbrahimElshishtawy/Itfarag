import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/error/exceptions.dart';
import '../../domain/entities/video_details_entity.dart';
import '../../domain/repositories/video_details_repository.dart';
import '../datasources/video_details_remote_datasource.dart';

class VideoDetailsRepositoryImpl implements VideoDetailsRepository {
  final VideoDetailsRemoteDataSource remoteDataSource;

  VideoDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, VideoDetailsEntity>> getVideoDetailsData(String id) async {
    try {
      final remoteData = await remoteDataSource.fetchVideoDetailsFromApi(id);
      return Right(remoteData);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure('Connection failed.'));
    }
  }
}
