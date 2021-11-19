import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:origa/http/response/case_details_response.dart';
import 'package:origa/models/case_details_api_model/case_details_api_model.dart';
import 'package:origa/models/case_details_api_model/result.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/hive_model/case_details_h_model.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  // double launguageValue = 0;
  // Box caseDetailsApiBox = Hive.box('CaseDetailsApiResultBox');
  // Box<CaseDetailsHiveModel> caseDetailsHiveBox =
  //     Hive.box<CaseDetailsHiveModel>('CaseDetailsHiveApiResultsBox12');

  // Address Details Screen
  String addressSelectedCustomerNotMetClip = '';
  String addressSelectedInvalidClip = '';

  TextEditingController addressInvalidRemarksController =
      TextEditingController();
  TextEditingController addressCustomerNotMetNextActionDateController =
      TextEditingController();
  TextEditingController addressCustomerNotMetRemarksController =
      TextEditingController();
  FocusNode addressInvalidRemarksFocusNode = FocusNode();
  FocusNode addressCustomerNotMetNextActionDateFocusNode = FocusNode();
  FocusNode addressCustomerNotMetRemarksFocusNode = FocusNode();

  List<CustomerMetGridModel> addressCustomerMetGridList = [];
  List<OtherFeedbackExpandModel> expandOtherFeedback = [];
  List<EventExpandModel> expandEvent = [];

  // Phone Details screen

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

  // Case Details Screen

  CaseDetailsApiModel caseDetailsResult = CaseDetailsApiModel();

  late TextEditingController loanAmountController = TextEditingController();
  late TextEditingController bankNameController = TextEditingController();
  late TextEditingController emiStartDateController = TextEditingController();
  late TextEditingController loanDurationController = TextEditingController();
  late TextEditingController posController = TextEditingController();
  late TextEditingController schemeCodeController = TextEditingController();
  late TextEditingController productController = TextEditingController();
  late TextEditingController batchNoController = TextEditingController();

  CaseDetailsBloc() : super(CaseDetailsInitial());
  @override
  Stream<CaseDetailsState> mapEventToState(CaseDetailsEvent event) async* {
    if (event is CaseDetailsInitialEvent) {
      yield CaseDetailsLoadingState();

      //check internet
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        print("djkdld");
        // print(caseDetailsHiveBox.get('c1')?.status);
      } else {
        Map<String, dynamic> caseDetailsData =
            await getCaseDetailsData('5f80375a86527c46deba2e5d');

        if (caseDetailsData["success"] == true) {
          Map<String, dynamic> jsonData = caseDetailsData["data"];

          caseDetailsResult = CaseDetailsApiModel.fromJson(jsonData);

          dynamic values = caseDetailsResult.result?.toJson();
          // caseDetailsHiveBox.clear();

          // caseDetailsHiveBox.put(
          //     'c1',
          //     CaseDetailsHiveModel(
          //       status: caseDetailsResult.status!,
          //       message: caseDetailsResult.message!,
          //       result: values,
          //     ));

          // caseDetailsHiveBox.add();

          // print(jsonEncode(caseDetailsHiveBox.values.first.result));
          // var caseDetail = CaseDetailsApiModel(
          //         message: caseDetailsHiveBox.values.first.message,
          //         status: caseDetailsHiveBox.values.first.status,
          //         result: Result.fromJson(
          //             jsonDecode(caseDetailsHiveBox.values.first.result)))
          //     .toJson();
          // print(jsonEncode(caseDetail));

          // caseDetailsApiBox.clear();
          // caseDetailsApiBox.add(caseDetailsResult.toJson());
          // if (caseDetailsApiBox.isEmpty) {
          //   print("is Empty");
          // } else {
          //   // loanAmountController.text = caseDetailsApiBox
          //   //     .getAt(0)['result']['caseDetails']['loanAmt']
          //   //     .toString();
          // }

          loanAmountController.text =
              caseDetailsResult.result?.caseDetails!.loanAmt.toString()
                  as String;
          loanDurationController.text =
              caseDetailsResult.result?.caseDetails!.loanDuration.toString()
                  as String;
          posController.text =
              caseDetailsResult.result?.caseDetails!.pos.toString() as String;
          schemeCodeController.text =
              caseDetailsResult.result?.caseDetails!.schemeCode.toString()
                  as String;
          emiStartDateController.text =
              caseDetailsResult.result?.caseDetails!.emiStartDate.toString()
                  as String;
          bankNameController.text =
              caseDetailsResult.result?.caseDetails!.bankName.toString()
                  as String;
          productController.text =
              caseDetailsResult.result?.caseDetails!.product.toString()
                  as String;
          batchNoController.text =
              caseDetailsResult.result?.caseDetails!.batchNo.toString()
                  as String;

          // yield SevenDaysLoadedState();
        } else {
          // message = weatherData["data"];
          // yield SevenDaysFailureState();
        }
      }

      // print(caseDetailsHiveBox.get('c1')?.message);
      // Result result1 = Result.fromJson(caseDetailsHiveBox.get('c1')?.result);
      // print(result1.caseDetails?.due);
      // CaseDetailsApiModel caseDetailsTemp = CaseDetailsApiModel(
      //     message: caseDetailsHiveBox.get('c1')?.message,
      //     status: caseDetailsHiveBox.get('c1')?.status,
      //     result: Result.fromJson(caseDetailsHiveBox.get('c1')?.result));
      // print(caseDetailsTemp.result?.caseDetails?.bankName);
      addressCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, StringResource.ptp),
        CustomerMetGridModel(ImageResource.rtp, StringResource.rtp),
        CustomerMetGridModel(ImageResource.dispute, StringResource.dispute),
        CustomerMetGridModel(ImageResource.remainder, StringResource.remainder),
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

      phoneCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, StringResource.ptp),
        CustomerMetGridModel(ImageResource.rtp, StringResource.rtp),
        CustomerMetGridModel(ImageResource.dispute, StringResource.dispute),
        CustomerMetGridModel(ImageResource.remainder, StringResource.remainder),
        CustomerMetGridModel(
            ImageResource.collections, StringResource.collections),
        CustomerMetGridModel(ImageResource.ots, StringResource.ots),
      ]);

      // multiCallDetilsList.addAll([
      //   MultiCallDetailsModel('PHONE NUMBER 01', '9841021453', true),
      //   MultiCallDetailsModel('PHONE NUMBER 02', '9841021453', false)
      // ]);

      yield CaseDetailsLoadedState();
    }
    if (event is ClickAddressBottomSheetEvent) {
      yield ClickAddressBottomSheetState();
    }
    if (event is ClickCallBottomSheetEvent) {
      yield ClickCallBottomSheetState();
    }
  }
}
