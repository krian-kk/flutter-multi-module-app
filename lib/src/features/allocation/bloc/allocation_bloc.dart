import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'allocation_event.dart';

part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc() : super(AllocationInitial()) {
    on<AllocationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      AllocationEvent event, Emitter<AllocationState> emit) async {
    if (event is AllocationInitialEvent) {
      if (await Permission.location.isGranted) {
        final Position result = await Geolocator.getCurrentPosition();
        //do api call and store currentLoc
      }
    }

    if (event is AllocationTabChangeEvent) {
      emit(AllocationTabChangedState(event.index));
    }

    if (event is NavigateSearchPageEvent) {
      emit(NavigateSearchPageState());
    }
  }
}
