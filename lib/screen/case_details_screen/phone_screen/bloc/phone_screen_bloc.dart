import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/base_equatable.dart';

part 'phone_screen_event.dart';
part 'phone_screen_state.dart';

class PhoneScreenBloc extends Bloc<PhoneScreenEvent, PhoneScreenState> {
  PhoneScreenBloc() : super(PhoneScreenInitial()) {
    on<PhoneScreenEvent>((event, emit) {
      if (event is PhoneScreenBottomSheetIntialEvent) {
        emit.call(PhoneScreenBottomSheetLoadedState());
        emit.call(PhoneScreenBottomSheetLoadingState());
      }
    });
  }
}
