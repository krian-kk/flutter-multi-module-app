import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'allocation_event.dart';

part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc() : super(AllocationInitial()) {
    on<AllocationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      AllocationEvent event, Emitter<AllocationState> emit) async {
    if (event is AllocationInitialEvent) {
      emit(AllocationLoadedState());
    }

    if (event is NavigateSearchPageEvent) {
      emit(NavigateSearchPageState());
    }
  }
}
