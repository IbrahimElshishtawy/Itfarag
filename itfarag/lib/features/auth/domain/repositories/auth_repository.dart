import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> getAuthData(String id);
}
