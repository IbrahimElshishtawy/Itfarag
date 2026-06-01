import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/notifications_entity.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<Either<Failure, NotificationsEntity>> call(String id) async {
    return await repository.getNotificationsData(id);
  }
}
