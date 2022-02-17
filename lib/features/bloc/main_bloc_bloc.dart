import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'main_bloc_event.dart';

part 'main_bloc_state.dart';

class MainBlocBloc extends Bloc<MainBlocEvent, MainBlocState> {
  MainBlocBloc({
    required MainBlocState initialState,
  }) : super(initialState) {
    on<InitialMainBlocEvent>(_buildInitialMainBlocEvent);
  }

  Future<void> _buildInitialMainBlocEvent(
    InitialMainBlocEvent event,
    Emitter<MainBlocState> emit,
  ) async {
    emit(ApplicationMainBlocState());
  }
}
