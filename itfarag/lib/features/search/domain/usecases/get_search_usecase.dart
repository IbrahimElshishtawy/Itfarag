import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/search_entity.dart';
import '../repositories/search_repository.dart';

class GetSearchUseCase {
  final SearchRepository repository;

  GetSearchUseCase(this.repository);

  Future<Either<Failure, SearchEntity>> call(String id) async {
    return await repository.getSearchData(id);
  }
}
