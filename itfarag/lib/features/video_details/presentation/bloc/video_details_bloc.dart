import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_details_event.dart';
import 'video_details_state.dart';
import '../../domain/usecases/get_video_details_usecase.dart';

class VideoDetailsBloc extends Bloc<VideoDetailsEvent, VideoDetailsState> {
  final GetVideoDetailsUseCase getVideoDetailsUseCase;

  VideoDetailsBloc({required this.getVideoDetailsUseCase}) : super(VideoDetailsInitial()) {
    on<LoadVideoDetailsEvent>((event, emit) async {
      emit(VideoDetailsLoading());
      final result = await getVideoDetailsUseCase(event.id);
      result.fold(
        (failure) => emit(VideoDetailsError(failure.message)),
        (entity) => emit(VideoDetailsLoaded(entity)),
      );
    });
  }
}
