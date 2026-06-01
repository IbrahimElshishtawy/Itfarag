import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../domain/usecases/get_home_usecase.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeUseCase getHomeUseCase;

  HomeBloc({required this.getHomeUseCase}) : super(HomeInitial()) {
    on<LoadHomeEvent>((event, emit) async {
      emit(HomeLoading());
      final result = await getHomeUseCase(event.id);
      result.fold(
        (failure) => emit(HomeError(failure.message)),
        (entity) => emit(HomeLoaded(entity)),
      );
    });
  }
}
