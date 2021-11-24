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

  Result offlineCaseDetailsValue = Result();

  var caseDetailsHiveBox =
      Hive.openBox<CaseDetailsHiveModel>('CaseDetailsHiveApiResultsBox19');
  // var Box = Hive.box<CaseDetailsHiveModel>('CaseDetailsHiveApiResultsBox19');

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

  // CaseDetailsApiModel caseDetailsResult = CaseDetailsApiModel();

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
        print('Please Connect Internet!');
        // print(caseDetailsHiveBox.get('c1')?.status);
      } else {
        Map<String, dynamic> caseDetailsData =
            await getCaseDetailsData('6181646813c5cf70dea671d2');

        if (caseDetailsData['success'] == true) {
          Map<String, dynamic> jsonData = caseDetailsData['data'];
          // print("Api values => ${jsonData['result']}");

          // caseDetailsResult = CaseDetailsApiModel.fromJson(jsonData);

          // dynamic values = caseDetailsResult.result?.toJson();
          // caseDetailsHiveBox.clear();

          caseDetailsHiveBox.then((value) => value.put(
              'c1',
              CaseDetailsHiveModel(
                status: jsonData['status'],
                message: jsonData['message'],
                result: jsonData['result'],
              )));

          // caseDetailsHiveBox.put(
          //     'c1',
          //     CaseDetailsHiveModel(
          //       status: jsonData['status'],
          //       message: jsonData['message'],
          //       result: jsonData['result'],
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

          // yield SevenDaysLoadedState();
        } else {
          // message = weatherData["data"];
          // yield SevenDaysFailureState();
        }
      }

      // print(caseDetailsHiveBox.get('c1')?.result);
      // caseDetailsHiveBox.then((value) =>
      //     offlineCaseDetailsValue = Result.fromJson(value.get('c1')?.result));

      await caseDetailsHiveBox.then((value) {
        offlineCaseDetailsValue = Result.fromJson(value.get('c1')?.result);
        // print(value.get('c1')?.result);
        // print("OfflineCas => ${offlineCaseDetailsValue.caseDetails?.cust}");
      });

      loanAmountController.text =
          offlineCaseDetailsValue.caseDetails!.loanAmt.toString();
      loanDurationController.text =
          offlineCaseDetailsValue.caseDetails!.loanDuration.toString();
      posController.text = offlineCaseDetailsValue.caseDetails!.pos.toString();
      schemeCodeController.text =
          offlineCaseDetailsValue.caseDetails!.schemeCode.toString();
      emiStartDateController.text =
          offlineCaseDetailsValue.caseDetails!.emiStartDate.toString();
      bankNameController.text =
          offlineCaseDetailsValue.caseDetails!.bankName.toString();
      productController.text =
          offlineCaseDetailsValue.caseDetails!.product.toString();
      batchNoController.text =
          offlineCaseDetailsValue.caseDetails!.batchNo.toString();
      // print("Offline values => ${offlineCaseDetailsValue.caseDetails?.cust}");

      // print(caseDetailsHiveBox.get('c1')?.message);
      // Result result1 = Result.fromJson(caseDetailsHiveBox.get('c1')?.result);
      // print(result1.caseDetails?.due);
      // CaseDetailsApiModel caseDetailsTemp = CaseDetailsApiModel(
      //     message: caseDetailsHiveBox.get('c1')?.message,
      //     status: caseDetailsHiveBox.get('c1')?.status,
      //     result: Result.fromJson(caseDetailsHiveBox.get('c1')?.result));
      // print(caseDetailsTemp.result?.caseDetails?.bankName);
      addressCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, StringResource.ptp,
            onTap: () => add(ClickPTPEvent())),
        CustomerMetGridModel(ImageResource.rtp, StringResource.rtp,
            onTap: () => add(ClickRTPEvent())),
        CustomerMetGridModel(ImageResource.dispute, StringResource.dispute,
            onTap: () => add(ClickDisputeEvent())),
        CustomerMetGridModel(ImageResource.remainder, StringResource.remainder,
            onTap: () => add(ClickRemainderEvent())),
        CustomerMetGridModel(
            ImageResource.collections, StringResource.collections,
            onTap: () => add(ClickCollectionsEvent())),
        CustomerMetGridModel(ImageResource.ots, StringResource.ots,
            onTap: () => add(ClickOTSEvent())),
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
        CustomerMetGridModel(ImageResource.ptp, StringResource.ptp,
            onTap: () => add(ClickPTPEvent())),
        CustomerMetGridModel(ImageResource.rtp, StringResource.rtp,
            onTap: () => add(ClickRTPEvent())),
        CustomerMetGridModel(ImageResource.dispute, StringResource.dispute,
            onTap: () => add(ClickDisputeEvent())),
        CustomerMetGridModel(ImageResource.remainder, StringResource.remainder,
            onTap: () => add(ClickRemainderEvent())),
        CustomerMetGridModel(
            ImageResource.collections, StringResource.collections,
            onTap: () => add(ClickCollectionsEvent())),
        CustomerMetGridModel(ImageResource.ots, StringResource.ots,
            onTap: () => add(ClickOTSEvent())),
      ]);

      yield CaseDetailsLoadedState();
    }
    if (event is ClickAddressBottomSheetEvent) {
      yield ClickAddressBottomSheetState();
    }
    if (event is ClickCallBottomSheetEvent) {
      yield ClickCallBottomSheetState();
    }
    if (event is ClickMainAddressBottomSheetEvent) {
      yield ClickMainAddressBottomSheetState();
    }
    if (event is ClickMainCallBottomSheetEvent) {
      yield ClickMainCallBottomSheetState();
    }
    if (event is ClickPopEvent) {
      yield ClickPopState();
    }
    if (event is ClickPTPEvent) {
      yield ClickPTPState();
    }
    if (event is ClickRTPEvent) {
      yield ClickRTPState();
    }
    if (event is ClickDisputeEvent) {
      yield ClickDisputeState();
    }
    if (event is ClickRemainderEvent) {
      yield ClickRemainderState();
    }
    if (event is ClickCollectionsEvent) {
      yield ClickCollectionsState();
    }
    if (event is ClickAddAddressEvent) {
      yield ClickAddAddressState();
    }
    if (event is ClickOTSEvent) {
      yield ClickOTSState();
    }
    if (event is ClickViewMapEvent) {
      yield ClickViewMapState();
    }
    if (event is ClickPhoneDetailEvent) {
      yield ClickPhoneDetailState();
    }

    if (event is ClickCallCustomerEvent) {
      yield ClickCallCustomerState();
    }
  }
}
