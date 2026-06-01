import 'package:flutter_bloc/flutter_bloc.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';
import '../../domain/usecases/get_subscription_usecase.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetSubscriptionUseCase getSubscriptionUseCase;

  SubscriptionBloc({required this.getSubscriptionUseCase}) : super(SubscriptionInitial()) {
    on<LoadSubscriptionEvent>((event, emit) async {
      emit(SubscriptionLoading());
      final result = await getSubscriptionUseCase(event.id);
      result.fold(
        (failure) => emit(SubscriptionError(failure.message)),
        (entity) => emit(SubscriptionLoaded(entity)),
      );
    });
  }
}
