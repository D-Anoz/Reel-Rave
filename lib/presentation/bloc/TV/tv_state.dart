part of 'tv_bloc.dart';

@immutable
abstract class TVState extends Equatable {
  @override
  List<Object> get props => [];
}

class TVInitialState extends TVState {}

class TVLoadingState extends TVState {}

class TVLoadedState extends TVState {
  final List<TvModel> tvLists;

  TVLoadedState({required this.tvLists});

  @override
  List<Object> get props => [
        tvLists
      ];
}

class TVErrorState extends TVState {
  final String errMsg;

  TVErrorState({required this.errMsg});

  @override
  List<Object> get props => [
        errMsg
      ];
}
