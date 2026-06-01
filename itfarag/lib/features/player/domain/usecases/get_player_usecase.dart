import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/player_entity.dart';
import '../repositories/player_repository.dart';

class GetPlayerUseCase {
  final PlayerRepository repository;

  GetPlayerUseCase(this.repository);

  Future<Either<Failure, PlayerEntity>> call(String id) async {
    return await repository.getPlayerData(id);
  }
}
