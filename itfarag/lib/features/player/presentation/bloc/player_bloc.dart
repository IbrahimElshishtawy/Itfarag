import 'package:flutter_bloc/flutter_bloc.dart';
import 'player_event.dart';
import 'player_state.dart';
import '../../domain/usecases/get_player_usecase.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayerUseCase getPlayerUseCase;

  PlayerBloc({required this.getPlayerUseCase}) : super(PlayerInitial()) {
    on<LoadPlayerEvent>((event, emit) async {
      emit(PlayerLoading());
      final result = await getPlayerUseCase(event.id);
      result.fold(
        (failure) => emit(PlayerError(failure.message)),
        (entity) => emit(PlayerLoaded(entity)),
      );
    });
  }
}
