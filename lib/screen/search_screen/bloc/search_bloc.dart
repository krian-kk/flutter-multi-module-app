import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc() : super(SearchScreenInitial());

  @override
  Stream<SearchScreenState> mapEventToState(SearchScreenEvent event) async* {
    if (event is SearchScreenInitialEvent) {
      yield SearchScreenLoadingState();
      Singleton.instance.buildContext = event.context;
      yield SearchScreenLoadedState();
    }

    if (event is NavigatePopEvent) {
      yield NavigatePopState();
    }
  }
}
