import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchEntity>> getSearchData(String id);
}
