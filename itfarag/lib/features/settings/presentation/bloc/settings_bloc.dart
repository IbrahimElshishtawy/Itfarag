import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import '../../domain/usecases/get_settings_usecase.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;

  SettingsBloc({required this.getSettingsUseCase}) : super(SettingsInitial()) {
    on<LoadSettingsEvent>((event, emit) async {
      emit(SettingsLoading());
      final result = await getSettingsUseCase(event.id);
      result.fold(
        (failure) => emit(SettingsError(failure.message)),
        (entity) => emit(SettingsLoaded(entity)),
      );
    });
  }
}
