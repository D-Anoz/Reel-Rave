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
  final List<MovieResult>? topRated;
  final List<ForYouModel>? forYouLists;
  final List<PopularResult>? popular;

  HomeLoadedState({this.upcomingLists, this.topRated, this.forYouLists, this.popular});
  @override
  List<Object> get props => [
        upcomingLists!,
        topRated!,
        forYouLists!,
        popular!
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
