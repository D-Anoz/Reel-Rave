import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:reelrave/services/remote/home_services.dart';

import '../../../model/forYou.dart';
import '../../../model/popular.dart';
import '../../../model/topRated.dart';
import '../../../model/upcoming_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeServices homeServices = HomeServices();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is HomeLoadedEvent) {
          try {
            final topRated = await homeServices.getTopRated();
            final popular = await homeServices.getPopular();
            emit(HomeLoadedState(topRated: topRated, popular: popular));
          } catch (e) {
            emit(HomeLoadingErrorState(errorMsg: e.toString()));
          }
        } else {
          print('Something is wrong');
        }
      },
    );
  }
}
