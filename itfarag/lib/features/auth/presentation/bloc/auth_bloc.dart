import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/get_auth_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthUseCase getAuthUseCase;

  AuthBloc({required this.getAuthUseCase}) : super(AuthInitial()) {
    on<LoadAuthEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await getAuthUseCase(event.id);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (entity) => emit(AuthLoaded(entity)),
      );
    });
  }
}
