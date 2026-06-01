import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/shorts_entity.dart';
import '../repositories/shorts_repository.dart';

class GetShortsUseCase {
  final ShortsRepository repository;

  GetShortsUseCase(this.repository);

  Future<Either<Failure, ShortsEntity>> call(String id) async {
    return await repository.getShortsData(id);
  }
}
