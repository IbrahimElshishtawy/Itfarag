import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import '../../domain/usecases/get_search_usecase.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchUseCase getSearchUseCase;

  SearchBloc({required this.getSearchUseCase}) : super(SearchInitial()) {
    on<LoadSearchEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await getSearchUseCase(event.id);
      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (entity) => emit(SearchLoaded(entity)),
      );
    });
  }
}
