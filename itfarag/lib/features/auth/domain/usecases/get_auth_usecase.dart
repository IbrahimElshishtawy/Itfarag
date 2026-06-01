import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class GetAuthUseCase {
  final AuthRepository repository;

  GetAuthUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> call(String id) async {
    return await repository.getAuthData(id);
  }
}
