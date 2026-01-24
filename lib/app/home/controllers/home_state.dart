import 'package:url_shortener_app/app/home/models/home_model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {
  final Exception error;

  HomeFailure({required this.error});
}

class HomeSuccess extends HomeState {
  final List<HomeModel> model;

  HomeSuccess({
    required this.model,
  });
}
