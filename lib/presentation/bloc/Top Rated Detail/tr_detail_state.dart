part of 'tr_detail_bloc.dart';

@immutable
abstract class TrDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrDetailInitialState extends TrDetailState {}

class TrDetailLoadingState extends TrDetailState {}

class TrDetailLoadedState extends TrDetailState {
  final TopRatedDetailModel topRatedDetails;
  final List<Genre> genre;

  TrDetailLoadedState({required this.topRatedDetails, required this.genre});

  @override
  List<Object> get props => [
        topRatedDetails,
        genre
      ];
}

class TrDetailErrorState extends TrDetailState {
  final String errMsg;

  TrDetailErrorState({required this.errMsg});

  @override
  List<Object> get props => [
        errMsg
      ];
}
