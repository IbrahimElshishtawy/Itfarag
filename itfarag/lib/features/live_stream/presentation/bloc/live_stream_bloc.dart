import 'package:flutter_bloc/flutter_bloc.dart';
import 'live_stream_event.dart';
import 'live_stream_state.dart';
import '../../domain/usecases/get_live_stream_usecase.dart';

class LiveStreamBloc extends Bloc<LiveStreamEvent, LiveStreamState> {
  final GetLiveStreamUseCase getLiveStreamUseCase;

  LiveStreamBloc({required this.getLiveStreamUseCase}) : super(LiveStreamInitial()) {
    on<LoadLiveStreamEvent>((event, emit) async {
      emit(LiveStreamLoading());
      final result = await getLiveStreamUseCase(event.id);
      result.fold(
        (failure) => emit(LiveStreamError(failure.message)),
        (entity) => emit(LiveStreamLoaded(entity)),
      );
    });
  }
}
