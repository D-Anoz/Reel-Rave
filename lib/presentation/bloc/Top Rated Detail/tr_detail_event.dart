part of 'tr_detail_bloc.dart';

@immutable
abstract class TRDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TRDetailsLoadedEvent extends TRDetailsEvent {
  final int id;
  TRDetailsLoadedEvent({required this.id});
  @override
  List<Object> get props => [
        id
      ];
}
