import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  String selectedCustomerNotMetClip = '';
  String selectedInvalidClip = '';
  TextEditingController customerNotMetNextActionDateController =
      TextEditingController();
  TextEditingController customerNotMetRemarksController =
      TextEditingController();
  TextEditingController invalidRemarksController = TextEditingController();

  FocusNode customerNotMetNextActionDateFocusNode = FocusNode();
  FocusNode customerNotMetRemarksFocusNode = FocusNode();
  FocusNode invalidRemarksFocusNode = FocusNode();

  List<OtherFeedbackExpandModel> expandOtherFeedback = [];
  List<EventExpandModel> expandEvent = [];

  List<CustomerMetGridModel> customerMetGridList = [];
  AddressBloc() : super(AddressInitial()) {
    on<AddressEvent>((event, emit) {
      if (event is AddressInitialEvent) {
        emit.call(AddressLoadingState());
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

        expandEvent.addAll([
          EventExpandModel(
              header: 'FIELD ALLOCATION',
              date: '7 Sep 2021',
              colloctorID: 'AGENT | HAR_fos4',
              remarks: 'XYZ'),
          EventExpandModel(
              header: 'TELECALLING | PTP',
              date: '12 May 2021',
              colloctorID: 'AGENT | HAR_fos4',
              remarks: 'XYZ'),
          EventExpandModel(
              header: 'FTELECALLING',
              date: '23 Oct 2021',
              colloctorID: 'AGENT | HAR_fos4',
              remarks: 'XYZ'),
        ]);

        expandOtherFeedback.addAll([
          OtherFeedbackExpandModel(header: 'ABC', subtitle: 'subtitle'),
          OtherFeedbackExpandModel(
              header: 'VEHICLE AVAILABLE', subtitle: 'subtitle'),
          OtherFeedbackExpandModel(
              header: 'COLLECTOR FEEDDBACK', subtitle: 'subtitle'),
        ]);
        emit.call(AddressLoadedState());
      }
    });
  }
}

// @override
//   Stream<AddressState> mapEventToState(AddressEvent event) async* {
//     if (event is AddressInitialEvent) {
//       yield AddressLoadingState();
//       customerMetGridList.addAll([
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//       ]);
//       yield AddressLoadedState();
//     }
//   }
