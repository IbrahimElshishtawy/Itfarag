import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/subscription_entity.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, SubscriptionEntity>> getSubscriptionData(String id);
}
