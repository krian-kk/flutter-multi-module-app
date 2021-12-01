import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/case_details_api_model/result.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/event_details_api_model/result.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/offline_helper/dynamic_table.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  // double launguageValue = 0;

  CaseDetailsResultModel offlineCaseDetailsValue = CaseDetailsResultModel();
  List<EventDetailsResultModel> offlineEventDetailsListValue = [];

  Future<Box<OrigoMapDynamicTable>> caseDetailsHiveBox =
      Hive.openBox<OrigoMapDynamicTable>('CaseDetailsHiveApiResultsBox');
  Future<Box<OrigoDynamicTable>> eventDetailsHiveBox =
      Hive.openBox<OrigoDynamicTable>('EventDetailsHiveApiResultsBox');
  // var Box = Hive.box<CaseDetailsHiveModel>('CaseDetailsHiveApiResultsBox19');

  // Address Details Screen
  String addressSelectedCustomerNotMetClip = '';
  String addressSelectedInvalidClip = '';

  final addressCustomerNotMetFormKey = GlobalKey<FormState>();
  final addressInvalidFormKey = GlobalKey<FormState>();

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

  final phoneUnreachableFormKey = GlobalKey<FormState>();
  final phoneInvalidFormKey = GlobalKey<FormState>();

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
      } else {
        // Map<String, dynamic> caseDetailsData =
        //     await APIRepository.getCaseDetailsData('6181646813c5cf70dea671d2');
        Map<String, dynamic> caseDetailsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.caseDetailsUrl + '6181646813c5cf70dea671d2');

        if (caseDetailsData['success'] == true) {
          Map<String, dynamic> jsonData = caseDetailsData['data'];
          // print("Api values => ${jsonData['result']}");

          // caseDetailsResult = CaseDetailsApiModel.fromJson(jsonData);

          // dynamic values = caseDetailsResult.result?.toJson();
          // caseDetailsHiveBox.clear();

          caseDetailsHiveBox.then((value) => value.put(
              'c1',
              OrigoMapDynamicTable(
                status: jsonData['status'],
                message: jsonData['message'],
                result: jsonData['result'],
              )));
        } else {
          // message = weatherData["data"];
          // yield SevenDaysFailureState();
        }
      }

      await caseDetailsHiveBox.then(
        (value) => offlineCaseDetailsValue =
            CaseDetailsResultModel.fromJson(value.get('c1')!.result),
      );

      loanAmountController.text = offlineCaseDetailsValue.caseDetails!.loanAmt
          .toString()
          .replaceAll('null', '-');
      loanDurationController.text = offlineCaseDetailsValue
          .caseDetails!.loanDuration
          .toString()
          .replaceAll('null', '-');
      posController.text = offlineCaseDetailsValue.caseDetails!.pos
          .toString()
          .replaceAll('null', '-');
      schemeCodeController.text = offlineCaseDetailsValue
          .caseDetails!.schemeCode
          .toString()
          .replaceAll('null', '-');
      emiStartDateController.text = offlineCaseDetailsValue
          .caseDetails!.emiStartDate
          .toString()
          .replaceAll('null', '-');
      bankNameController.text = offlineCaseDetailsValue.caseDetails!.bankName
          .toString()
          .replaceAll('null', '-');
      productController.text = offlineCaseDetailsValue.caseDetails!.product
          .toString()
          .replaceAll('null', '-');
      batchNoController.text = offlineCaseDetailsValue.caseDetails!.batchNo
          .toString()
          .replaceAll('null', '-');

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
            onTap: () => add(ClickOpenBottomSheetEvent(StringResource.ptp))),
        CustomerMetGridModel(ImageResource.rtp, StringResource.rtp,
            onTap: () => add(ClickOpenBottomSheetEvent(StringResource.rtp))),
        CustomerMetGridModel(ImageResource.dispute, StringResource.dispute,
            onTap: () =>
                add(ClickOpenBottomSheetEvent(StringResource.dispute))),
        CustomerMetGridModel(ImageResource.remainder, StringResource.remainder,
            onTap: () =>
                add(ClickOpenBottomSheetEvent(StringResource.remainder))),
        CustomerMetGridModel(
            ImageResource.collections, StringResource.collections,
            onTap: () =>
                add(ClickOpenBottomSheetEvent(StringResource.collections))),
        CustomerMetGridModel(ImageResource.ots, StringResource.ots,
            onTap: () => add(ClickOpenBottomSheetEvent(StringResource.ots))),
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
            onTap: () => add(ClickOpenBottomSheetEvent(StringResource.ptp))),
        CustomerMetGridModel(ImageResource.rtp, StringResource.rtp,
            onTap: () => add(ClickOpenBottomSheetEvent(StringResource.rtp))),
        CustomerMetGridModel(ImageResource.dispute, StringResource.dispute,
            onTap: () =>
                add(ClickOpenBottomSheetEvent(StringResource.dispute))),
        CustomerMetGridModel(ImageResource.remainder, StringResource.remainder,
            onTap: () =>
                add(ClickOpenBottomSheetEvent(StringResource.remainder))),
        CustomerMetGridModel(
            ImageResource.collections, StringResource.collections,
            onTap: () =>
                add(ClickOpenBottomSheetEvent(StringResource.collections))),
        CustomerMetGridModel(ImageResource.ots, StringResource.ots,
            onTap: () => add(ClickOpenBottomSheetEvent(StringResource.ots))),
      ]);

      yield CaseDetailsLoadedState();
    }
    if (event is ClickMainAddressBottomSheetEvent) {
      yield ClickMainAddressBottomSheetState(event.index);
    }
    if (event is ClickMainCallBottomSheetEvent) {
      yield ClickMainCallBottomSheetState(event.index);
    }
    if (event is ClickViewMapEvent) {
      yield ClickViewMapState();
    }
    if (event is ClickCallCustomerEvent) {
      yield ClickCallCustomerState();
    }
    if (event is ClickCaseDetailsEvent) {
      yield CallCaseDetailsState();
    }

    if (event is ClickOpenBottomSheetEvent) {
      switch (event.title) {
        case StringResource.eventDetails:
          if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            print('Please Connect Internet!');
          } else {
            // Map<String, dynamic> getEventDetailsData =
            //     await APIRepository.getEventDetailsData(
            //         '5f80375a86527c46deba2e62');

            Map<String, dynamic> getEventDetailsData =
                await APIRepository.apiRequest(APIRequestType.GET,
                    HttpUrl.profileUrl + '5f80375a86527c46deba2e62');

            if (getEventDetailsData['success'] == true) {
              Map<String, dynamic> jsonData = getEventDetailsData['data'];

              eventDetailsHiveBox.then((value) => value.put(
                  'EventDetails1',
                  OrigoDynamicTable(
                    status: jsonData['status'],
                    message: jsonData['message'],
                    result: jsonData['result'],
                  )));
            } else {
              // message = weatherData["data"];
              // yield SevenDaysFailureState();
            }
          }
          await eventDetailsHiveBox.then((value) {
            for (var element in value.get('EventDetails1')!.result) {
              offlineEventDetailsListValue.add(EventDetailsResultModel.fromJson(
                  Map<String, dynamic>.from(element)));
            }
          });

          break;
        default:
      }

      yield ClickOpenBottomSheetState(event.title);
    }
  }
}
