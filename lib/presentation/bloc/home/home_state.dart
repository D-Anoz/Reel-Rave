part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<UpcomingModel>? upcomingLists;
  final List<MovieResult>? results;
  final List<ForYouModel>? forYouLists;

  HomeLoadedState({this.upcomingLists, this.results, this.forYouLists});
  @override
  List<Object> get props => [
        upcomingLists!,
        results!,
        forYouLists!
      ];
}

class HomeLoadingErrorState extends HomeState {
  final String errorMsg;

  HomeLoadingErrorState({required this.errorMsg});

  @override
  List<Object> get props => [
        errorMsg
      ];
}
