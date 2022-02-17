part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class LoadingHomeState extends HomeState {
  final bool isLoading;

  LoadingHomeState({required this.isLoading});
}

class ErrorState extends HomeState {
  final Object error;

  ErrorState({required this.error});
}

class SuccessHomeState extends HomeState {
  final List<Photo>? responsePhoto;
  SuccessHomeState({this.responsePhoto});
}
