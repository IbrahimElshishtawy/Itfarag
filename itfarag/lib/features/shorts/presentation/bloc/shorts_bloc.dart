import 'package:flutter_bloc/flutter_bloc.dart';
import 'shorts_event.dart';
import 'shorts_state.dart';
import '../../domain/usecases/get_shorts_usecase.dart';

class ShortsBloc extends Bloc<ShortsEvent, ShortsState> {
  final GetShortsUseCase getShortsUseCase;

  ShortsBloc({required this.getShortsUseCase}) : super(ShortsInitial()) {
    on<LoadShortsEvent>((event, emit) async {
      emit(ShortsLoading());
      final result = await getShortsUseCase(event.id);
      result.fold(
        (failure) => emit(ShortsError(failure.message)),
        (entity) => emit(ShortsLoaded(entity)),
      );
    });
  }
}
