import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'phone_event.dart';
part 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  String selectedUnreadableClip = '';
  String selectedInvalidClip = '';
  List<CustomerMetGridModel> customerMetGridList = [];

  TextEditingController unreachableNextActionDateController =
      TextEditingController();
  TextEditingController unreachableRemarksController = TextEditingController();
  TextEditingController invalidRemarksController = TextEditingController();

  PhoneBloc() : super(PhoneInitial()) {
    on<PhoneEvent>((event, emit) {
      if (event is PhoneInitialEvent) {
        emit.call(PhoneLoadingState());
        customerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp, StringResource.ptp),
          CustomerMetGridModel(ImageResource.rtp, StringResource.rtp),
          CustomerMetGridModel(ImageResource.dispute, StringResource.dispute),
          CustomerMetGridModel(
              ImageResource.remainder, StringResource.remainder),
          CustomerMetGridModel(
              ImageResource.collections, StringResource.collections),
          CustomerMetGridModel(ImageResource.ots, StringResource.ots),
        ]);
        emit.call(PhoneLoadedState());
      }
    });
  }
}
