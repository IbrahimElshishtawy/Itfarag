import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Either<Failure, SettingsEntity>> call(String id) async {
    return await repository.getSettingsData(id);
  }
}
