import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/notifications_entity.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, NotificationsEntity>> getNotificationsData(String id);
}
