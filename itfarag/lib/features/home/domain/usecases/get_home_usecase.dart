import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeUseCase {
  final HomeRepository repository;

  GetHomeUseCase(this.repository);

  Future<Either<Failure, HomeEntity>> call(String id) async {
    return await repository.getHomeData(id);
  }
}
