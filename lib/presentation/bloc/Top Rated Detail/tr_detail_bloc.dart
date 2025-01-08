import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/tr_detail_model.dart';
import '../../../services/remote/tr_detail_services.dart';

part 'tr_detail_state.dart';
part 'tr_detail_event.dart';

class TrDetailBloc extends Bloc<TRDetailsEvent, TrDetailState> {
  final TopRatedDetailServices topRatedDetailServices = TopRatedDetailServices();
  TrDetailBloc() : super(TrDetailInitialState()) {
    on<TRDetailsEvent>(
      (event, emit) async {
        if (event is TRDetailsLoadedEvent) {
          emit(TrDetailLoadingState());
          try {
            final topRatedDetail = await topRatedDetailServices.fetchTRD(event.id);
            final item = topRatedDetail.genres;
            print(topRatedDetail);
            emit(TrDetailLoadedState(topRatedDetails: topRatedDetail, genre: item));
          } catch (e) {
            emit(TrDetailErrorState(errMsg: e.toString()));
          }
        } else {
          debugPrint('Something is wrong');
        }
      },
    );
  }
}
