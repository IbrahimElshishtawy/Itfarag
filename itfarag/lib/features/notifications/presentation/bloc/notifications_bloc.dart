import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';
import '../../domain/usecases/get_notifications_usecase.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationsBloc({required this.getNotificationsUseCase}) : super(NotificationsInitial()) {
    on<LoadNotificationsEvent>((event, emit) async {
      emit(NotificationsLoading());
      final result = await getNotificationsUseCase(event.id);
      result.fold(
        (failure) => emit(NotificationsError(failure.message)),
        (entity) => emit(NotificationsLoaded(entity)),
      );
    });
  }
}
