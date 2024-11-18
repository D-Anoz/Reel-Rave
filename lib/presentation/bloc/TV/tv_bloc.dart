import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/model/tv_model.dart';
import 'package:reelrave/services/remote/tv_services.dart';

part 'tv_state.dart';
part 'tv_event.dart';

class TVBloc extends Bloc<TVEvent, TVState> {
  final TvServices tvServices = TvServices();
  TVBloc() : super(TVInitialState()) {
    on<TVEvent>(
      (event, emit) async {
        if (event is TVLoadedEvent) {
          try {
            final tvList = await tvServices.getTVlist();
            emit(TVLoadedState(tvLists: tvList));
          } catch (e) {
            emit(TVErrorState(errMsg: e.toString()));
          }
        } else {
          debugPrint('Something is wrong');
        }
      },
    );
  }
}
