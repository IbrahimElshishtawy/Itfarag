import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(String id) async {
    return await repository.getProfileData(id);
  }
}
