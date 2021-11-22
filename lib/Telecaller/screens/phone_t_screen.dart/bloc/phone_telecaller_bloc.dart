import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'phone_telecaller_event.dart';
part 'phone_telecaller_state.dart';

class PhoneTelecallerBloc
    extends Bloc<PhoneTelecallerEvent, PhoneTelecallerState> {
  String phoneSelectedUnreadableClip = '';
  String phoneSelectedInvalidClip = '';
  List<CustomerMetGridModel> phoneCustomerMetGridList = [];

  TextEditingController phoneUnreachableNextActionDateController =
      TextEditingController();
  TextEditingController phoneUnreachableRemarksController =
      TextEditingController();
  TextEditingController phoneInvalidRemarksController = TextEditingController();

  FocusNode phoneUnreachableNextActionDateFocusNode = FocusNode();
  FocusNode phoneUnreachableRemarksFocusNode = FocusNode();
  FocusNode phoneInvalidRemarksFocusNode = FocusNode();
  PhoneTelecallerBloc() : super(PhoneTelecallerInitial()) {
    on<PhoneTelecallerEvent>((event, emit) {
      if (event is PhoneTelecallerInitialEvent) {
        emit.call(PhoneTelecallerLoadingState());
        phoneCustomerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp, StringResource.ptp),
          CustomerMetGridModel(ImageResource.rtp, StringResource.rtp),
          CustomerMetGridModel(ImageResource.dispute, StringResource.dispute),
          CustomerMetGridModel(
              ImageResource.remainder, StringResource.remainder),
          CustomerMetGridModel(
              ImageResource.collections, StringResource.collections),
          CustomerMetGridModel(ImageResource.ots, StringResource.ots),
        ]);
        emit.call(PhoneTelecallerLoadedState());
      }
    });
  }
}
