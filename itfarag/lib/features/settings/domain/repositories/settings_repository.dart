import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, SettingsEntity>> getSettingsData(String id);
}
