import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../domain/usecases/get_favorites_usecase.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;

  FavoritesBloc({required this.getFavoritesUseCase}) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      final result = await getFavoritesUseCase(event.id);
      result.fold(
        (failure) => emit(FavoritesError(failure.message)),
        (entity) => emit(FavoritesLoaded(entity)),
      );
    });
  }
}
