import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionUseCase {
  final SubscriptionRepository repository;

  GetSubscriptionUseCase(this.repository);

  Future<Either<Failure, SubscriptionEntity>> call(String id) async {
    return await repository.getSubscriptionData(id);
  }
}
