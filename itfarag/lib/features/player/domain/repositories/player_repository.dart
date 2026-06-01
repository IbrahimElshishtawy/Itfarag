import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/player_entity.dart';

abstract class PlayerRepository {
  Future<Either<Failure, PlayerEntity>> getPlayerData(String id);
}
