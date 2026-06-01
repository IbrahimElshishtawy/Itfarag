import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_event.dart';
import 'video_state.dart';
import '../../domain/usecases/get_video_usecase.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideoUseCase getVideoUseCase;

  VideoBloc({required this.getVideoUseCase}) : super(VideoInitial()) {
    on<LoadVideoEvent>((event, emit) async {
      emit(VideoLoading());
      final result = await getVideoUseCase(event.id);
      result.fold(
        (failure) => emit(VideoError(failure.message)),
        (entity) => emit(VideoLoaded(entity)),
      );
    });
  }
}
