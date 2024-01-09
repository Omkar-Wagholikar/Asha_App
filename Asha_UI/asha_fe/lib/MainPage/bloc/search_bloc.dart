import 'dart:async';
import 'package:asha_fe/Utils/networking.dart';
import 'package:bloc/bloc.dart';
import '../data/search_model.dart';
import 'package:flutter/material.dart';

part 'search_events.dart';
part 'search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<InitialSearchEvent>(initialSearchEvent);
    on<SearchButtonPressedEvent>(searchButtonPressedEvent);
  }

  FutureOr<void> initialSearchEvent(
      InitialSearchEvent event, Emitter<SearchState> emit) async {
    print("Initial search event");
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
