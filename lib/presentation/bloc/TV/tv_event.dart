part of 'tv_bloc.dart';

@immutable
abstract class TVEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TVLoadedEvent extends TVEvent {
  @override
  List<Object> get props => [];
}

class RefreshTVEvent extends TVEvent {
  @override
  List<Object> get props => [];
}

class TVSaveEvent extends TVEvent {
  final List<int> savedStatus;
  final String message;

  TVSaveEvent({required this.savedStatus, required this.message});

  @override
  List<Object> get props => [
        savedStatus,
        message
      ];
}
