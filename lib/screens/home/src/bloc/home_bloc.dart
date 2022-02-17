import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:my_wallpaper/common/network/models/response/photos_model.dart';
import 'package:my_wallpaper/common/providers/network_provider.dart';
import 'package:path_provider/path_provider.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkProvider _networkProvider;

  StreamSubscription<bool>? updateScreenSubscription;

  HomeBloc({
    required HomeState initialState,
    required NetworkProvider networkProvider,
  })  : _networkProvider = networkProvider,
        super(initialState) {
    on<InitialHomeEvent>(_buildInitialHomeEvent);

  }

  @override
  Future<void> close() {
    updateScreenSubscription?.cancel();
    return super.close();
  }

  Future<void> _buildInitialHomeEvent(
    InitialHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingHomeState(isLoading: true));
    try {
      final response = await _networkProvider.getPhotos();

      emit(LoadingHomeState(isLoading: false));
      emit(SuccessHomeState(responsePhoto: response.photos));
    } catch (e) {
      emit(ErrorState(error: e));
    }
  }
}
