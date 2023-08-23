import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/base_equatable.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_onEvent);
  }

  Future<void> _onEvent(SearchEvent event, Emitter<SearchState> emit) async {
    if (event is SearchInitialEvent) {
      // emit(SearchLoadingState());
      // Singleton.instance.buildContext = event.context;
      emit(SearchLoadedState());
    }

    if (event is NavigatePopEvent) {
      emit(NavigatePopState());
    }
  }
}
