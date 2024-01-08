import 'dart:async';
import 'package:asha_fe/utils/networking.dart';
import 'package:bloc/bloc.dart';
import '../data/search_model.dart';
import 'package:flutter/material.dart';

part 'searching_events.dart';
part 'searching_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<InitialSearchEvent>(initialSearchEvent);
    on<SearchButtonPressedEvent>(searchButtonPressedEvent);
  }

  FutureOr<void> initialSearchEvent(
      InitialSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingSuccess(searchModel: SearchModel(answer: {}, query: "")));
  }

  FutureOr<void> searchButtonPressedEvent(
      SearchButtonPressedEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    await Networking.fetchData(event.query).then((Map<String, dynamic> res) {
      emit(SearchLoadingSuccess(
          searchModel: SearchModel(answer: res, query: res['query'])));
    });
  }
}
