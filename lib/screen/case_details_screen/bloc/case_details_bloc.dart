import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/address_invalid_post_model/address_invalid_post_model.dart';
import 'package:origa/models/case_details_api_model/case_details_api_model.dart';
import 'package:origa/models/case_details_api_model/result.dart';
import 'package:origa/models/contractor_detail_model.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/customer_not_met_post_model/customer_not_met_post_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/event_details_api_model/event_details_api_model.dart';
import 'package:origa/models/event_details_api_model/result.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/models/phone_invalid_post_model/phone_invalid_post_model.dart';
import 'package:origa/models/phone_unreachable_post_model/phone_unreachable_post_model.dart';
import 'package:origa/offline_helper/dynamic_table.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  String? caseId;
  bool isSubmit = true;

  // String? agrRef;
  // String eventCode = ;

  int? indexValue;
  String? userType;

  // Online Purpose
  // bool isNoInternet = false;
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';
  CaseDetailsApiModel caseDetailsAPIValue = CaseDetailsApiModel();
  EventDetailsApiModel eventDetailsAPIValue = EventDetailsApiModel();
  ContractorDetailsModel contractorDetailsValue = ContractorDetailsModel();

  // CaseDetailsResultModel offlineCaseDetailsValue = CaseDetailsResultModel();
  // List<EventDetailsResultModel> offlineEventDetailsListValue = [];

  // Future<Box<OrigoMapDynamicTable>> caseDetailsHiveBox =
  //     Hive.openBox<OrigoMapDynamicTable>('CaseDetailsHiveApiResultsBox');
  // Future<Box<OrigoDynamicTable>> eventDetailsHiveBox =
  //     Hive.openBox<OrigoDynamicTable>('EventDetailsHiveApiResultsBox');
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
      Singleton.instance.buildContext = event.context;
      caseId = event.paramValues['caseID'];

      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString(Constants.userType);

      // agrRef = _pref.getString(Constants.agentRef);

      //check internet
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        isNoInternetAndServerError = true;
        noInternetAndServerErrorMsg =
            Languages.of(event.context!)!.noInternetConnection;
        yield NoInternetState();
      } else {
        isNoInternetAndServerError = false;
        Map<String, dynamic> caseDetailsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.caseDetailsUrl + 'caseId=$caseId',
            isPop: true);

        if (caseDetailsData[Constants.success] == true) {
          Map<String, dynamic> jsonData = caseDetailsData['data'];
          caseDetailsAPIValue = CaseDetailsApiModel.fromJson(jsonData);
          // caseDetailsHiveBox.then((value) => value.put(
          //     'case' + caseId.toString(),
          //     OrigoMapDynamicTable(
          //       status: jsonData['status'],
          //       message: jsonData['message'],
          //       result: jsonData['result'],
          //     )));
        } else if (caseDetailsData['statusCode'] == 401 ||
            caseDetailsData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          noInternetAndServerErrorMsg = caseDetailsData['data'];
        }
      }

      // await caseDetailsHiveBox.then(
      //   (value) => offlineCaseDetailsValue = CaseDetailsResultModel.fromJson(
      //       value.get('case' + caseId.toString())!.result),
      // );

      Singleton.instance.overDueAmount =
          caseDetailsAPIValue.result?.caseDetails!.odVal.toString() ?? '';

      loanAmountController.text = caseDetailsAPIValue
              .result?.caseDetails!.loanAmt
              .toString()
              .replaceAll('null', '-') ??
          '-';
      loanDurationController.text = caseDetailsAPIValue
              .result?.caseDetails!.loanDuration
              .toString()
              .replaceAll('null', '-') ??
          '_';
      posController.text = caseDetailsAPIValue.result?.caseDetails!.pos
              .toString()
              .replaceAll('null', '-') ??
          '_';
      schemeCodeController.text = caseDetailsAPIValue
              .result?.caseDetails!.schemeCode
              .toString()
              .replaceAll('null', '-') ??
          '_';
      emiStartDateController.text = caseDetailsAPIValue
              .result?.caseDetails!.emiStartDate
              .toString()
              .replaceAll('null', '-') ??
          '_';
      bankNameController.text = caseDetailsAPIValue
              .result?.caseDetails!.bankName
              .toString()
              .replaceAll('null', '-') ??
          '_';
      productController.text = caseDetailsAPIValue.result?.caseDetails!.product
              .toString()
              .replaceAll('null', '-') ??
          '_';
      batchNoController.text = caseDetailsAPIValue.result?.caseDetails!.batchNo
              .toString()
              .replaceAll('null', '-') ??
          '_';

      addressCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, Constants.ptp,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.ptp,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.rtp, Constants.rtp,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.rtp,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.dispute, Constants.dispute,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.dispute,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.remainder,
            (Constants.remainder + '/CB').toUpperCase(),
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.remainder,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.collections, Constants.collections,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.collections,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.ots, Constants.ots,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.ots,
                caseDetailsAPIValue.result?.addressDetails!, false))),
      ]);

      // expandOtherFeedback.addAll([
      //   OtherFeedbackExpandModel(header: 'ABC', subtitle: 'subtitle'),
      //   OtherFeedbackExpandModel(
      //       header: 'VEHICLE AVAILABLE', subtitle: 'subtitle'),
      //   OtherFeedbackExpandModel(
      //       header: 'COLLECTOR FEEDDBACK', subtitle: 'subtitle'),
      // ]);
      phoneCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, Constants.ptp,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.ptp, caseDetailsAPIValue.result?.callDetails!, true)),
            isCall: true),
        CustomerMetGridModel(ImageResource.rtp, Constants.rtp,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.rtp, caseDetailsAPIValue.result?.callDetails!, true)),
            isCall: true),
        CustomerMetGridModel(ImageResource.dispute, Constants.dispute,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.dispute,
                caseDetailsAPIValue.result?.callDetails!, true)),
            isCall: true),
        CustomerMetGridModel(ImageResource.remainder,
            (Constants.remainder + '/CB').toUpperCase(),
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.remainder,
                caseDetailsAPIValue.result?.callDetails!, true)),
            isCall: true),
        CustomerMetGridModel(ImageResource.collections, Constants.collections,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.collections,
                caseDetailsAPIValue.result?.callDetails!, true)),
            isCall: true),
        CustomerMetGridModel(ImageResource.ots, Constants.ots,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.ots, caseDetailsAPIValue.result?.callDetails!, true)),
            isCall: true),
      ]);

      yield CaseDetailsLoadedState();
    }
    if (event is ClickMainAddressBottomSheetEvent) {
      indexValue = event.index;
      yield ClickMainAddressBottomSheetState(event.index);
    }
    if (event is ClickMainCallBottomSheetEvent) {
      indexValue = event.index;
      yield ClickMainCallBottomSheetState(event.index);
    }
    if (event is ClickViewMapEvent) {
      yield ClickViewMapState();
    }
    // if (event is ClickCallCustomerEvent) {
    //   // yield ClickCallCustomerState();
    // }
    if (event is ClickCaseDetailsEvent) {
      yield CallCaseDetailsState(paramValues: event.paramValues);
    }

    if (event is ClickPushAndPOPCaseDetailsEvent) {
      yield PushAndPOPNavigationCaseDetailsState(
          paramValues: event.paramValues);
    }

    if (event is ClickOpenBottomSheetEvent) {
      switch (event.title) {
        case Constants.eventDetails:
          if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            yield NoInternetState();
          } else {
            Map<String, dynamic> getEventDetailsData =
                await APIRepository.apiRequest(
                    APIRequestType.GET,
                    HttpUrl.eventDetailsUrl(
                        caseId: caseId, userType: userType));

            if (getEventDetailsData[Constants.success] == true) {
              Map<String, dynamic> jsonData = getEventDetailsData['data'];

              eventDetailsAPIValue = EventDetailsApiModel.fromJson(jsonData);
              // print(getEventDetailsData['data']['result'][3]['eventAttr']);

              // eventDetailsHiveBox.then((value) => value.put(
              //     'EventDetails1',
              //     OrigoDynamicTable(
              //       status: jsonData['status'],
              //       message: jsonData['message'],
              //       result: jsonData['result'],
              //     )));
            } else {
              AppUtils.showToast(getEventDetailsData['data']['message']);
            }
          }
          // await eventDetailsHiveBox.then((value) {
          //   value.get('EventDetails1')?.result.forEach((element) {
          //     offlineEventDetailsListValue.add(EventDetailsResultModel.fromJson(
          //         Map<String, dynamic>.from(element)));
          //   })
          // });
          break;
        case Constants.otherFeedback:
          if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            yield NoInternetState();
          } else {
            Map<String, dynamic> getContractorDetails =
                await APIRepository.apiRequest(
                    APIRequestType.GET, HttpUrl.contractorDetail);

            if (getContractorDetails[Constants.success] == true) {
              Map<String, dynamic> jsonData = getContractorDetails['data'];

              contractorDetailsValue =
                  ContractorDetailsModel.fromJson(jsonData);
            } else {
              AppUtils.showToast(getContractorDetails['data']['message']);
            }
          }
          break;
        default:
      }

      yield ClickOpenBottomSheetState(event.title, event.list!, event.isCall);
    }

    if (event is PostImageCapturedEvent) {
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.imageCaptured + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is ClickCustomerNotMetButtonEvent) {
      yield DisableCustomerNotMetBtnState();
      Map<String, dynamic> resultValue = {'success': false};
      if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.leftMessage) {
        resultValue = await customerNotMetButtonClick(
          Constants.leftMessage,
          caseId.toString(),
          HttpUrl.leftMessageUrl(
            'leftMessage',
            userType.toString(),
          ),
          'PTP',
          {
            'cType': caseDetailsAPIValue
                .result?.addressDetails?[indexValue!]['cType']
                .toString(),
            'value': caseDetailsAPIValue
                .result?.addressDetails?[indexValue!]['value']
                .toString(),
            'health': ConstantEventValues.addressCustomerNotMetHealth,
            'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
          },
        );
      } else if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.doorLocked) {
        resultValue = await customerNotMetButtonClick(
          Constants.doorLocked,
          caseId.toString(),
          HttpUrl.doorLockedUrl('doorLocked', userType.toString()),
          'NEW',
          [
            {
              'cType': caseDetailsAPIValue
                  .result?.addressDetails?[indexValue!]['cType']
                  .toString(),
              'value': caseDetailsAPIValue
                  .result?.addressDetails?[indexValue!]['value']
                  .toString(),
              'health': ConstantEventValues.addressCustomerNotMetHealth,
              // 'resAddressId_0': '6181646813c5cf70dea671d2',
              'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
            }
          ],
        );
      } else if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.entryRestricted) {
        resultValue = await customerNotMetButtonClick(
          Constants.entryRestricted,
          caseId.toString(),
          HttpUrl.entryRestrictedUrl('entryRestricted', userType.toString()),
          'PTP',
          [
            {
              'cType': caseDetailsAPIValue
                  .result?.addressDetails?[indexValue!]['cType']
                  .toString(),
              'value': caseDetailsAPIValue
                  .result?.addressDetails?[indexValue!]['value']
                  .toString(),
              'health': ConstantEventValues.addressCustomerNotMetHealth,
              // 'resAddressId_0': '6181646813c5cf70dea671d2',
              'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
            }
          ],
        );
      }
      if (resultValue[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableCustomerNotMetBtnState();
    }

    if (event is ClickAddressInvalidButtonEvent) {
      yield DisableAddressInvalidBtnState();
      late Map<String, dynamic> resultValue = {Constants.success: false};
      if (addressInvalidFormKey.currentState!.validate()) {
        if (addressSelectedInvalidClip != '') {
          if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.wrongAddress) {
            resultValue = await addressInvalidButtonClick(
              Constants.wrongAddress,
              caseId.toString(),
              'TELEVT008',
              HttpUrl.wrongAddressUrl(
                'invalidAddress',
                userType.toString(),
              ),
              'PTP',
            );
          } else if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.shifted) {
            resultValue = await addressInvalidButtonClick(
              Constants.shifted,
              caseId.toString(),
              'TELEVT008',
              HttpUrl.shiftedUrl('shifted', userType.toString()),
              'REVIEW',
            );
          } else if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.addressNotFound) {
            resultValue = await addressInvalidButtonClick(
              Constants.addressNotFound,
              caseId.toString(),
              'TELEVT008',
              HttpUrl.addressNotFoundUrl(
                'addressNotFound',
                userType.toString(),
              ),
              'PTP',
            );
          }
        } else {
          AppUtils.showToast(Constants.pleaseSelectOptions);
        }
      }
      if (resultValue[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableAddressInvalidBtnState();
    }

    if (event is ClickPhoneInvalidButtonEvent) {
      yield DisablePhoneInvalidBtnState();
      late Map<String, dynamic> resultValue = {Constants.success: false};
      if (phoneInvalidFormKey.currentState!.validate()) {
        if (phoneSelectedInvalidClip != '') {
          if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.doesNotExist) {
            resultValue = await phoneInvalidButtonClick(
                Constants.doesNotExist,
                caseId.toString(),
                'TELEVT008',
                HttpUrl.numberNotWorkingUrl(
                    'doesNotExist', userType.toString()));
          } else if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.incorrectNumber) {
            resultValue = await phoneInvalidButtonClick(
              Constants.incorrectNumber,
              caseId.toString(),
              'TELEVT008',
              HttpUrl.incorrectNumberUrl('incorrectNo', userType.toString()),
            );
          } else if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.numberNotWorking) {
            resultValue = await phoneInvalidButtonClick(
              Constants.numberNotWorking,
              caseId.toString(),
              'TELEVT008',
              HttpUrl.numberNotWorkingUrl(
                  'numberNotWorking', userType.toString()),
            );
          } else if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.notOperational) {
            resultValue = await phoneInvalidButtonClick(
                Constants.notOpeartional,
                caseId.toString(),
                'TELEVT008',
                HttpUrl.notOperationalUrl(
                    'notOperational', userType.toString()));
          }
        } else {
          AppUtils.showToast(Constants.pleaseSelectOptions);
        }
      }
      if (resultValue[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnablePhoneInvalidBtnState();
    }

    if (event is ClickPhoneUnreachableSubmitedButtonEvent) {
      yield DisableUnreachableBtnState();
      late Map<String, dynamic> resultValue;
      if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.lineBusy) {
        resultValue = await unreachableButtonClick(
          Constants.lineBusy,
          caseId.toString(),
          'TELEVT007',
          HttpUrl.unreachableUrl(
            'lineBusy',
            userType.toString(),
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.switchOff) {
        resultValue = await unreachableButtonClick(
          Constants.switchOff,
          caseId.toString(),
          'TELEVT007',
          HttpUrl.unreachableUrl(
            'switchOff',
            userType.toString(),
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.rnr) {
        resultValue = await unreachableButtonClick(
          Constants.rnr,
          caseId.toString(),
          'TELEVT011',
          HttpUrl.unreachableUrl(
            'RNR',
            userType.toString(),
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.outOfNetwork) {
        resultValue = await unreachableButtonClick(
          Constants.outOfNetwork,
          caseId.toString(),
          'TELEVT007',
          HttpUrl.unreachableUrl(
            'outOfNetwork',
            userType.toString(),
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.disConnecting) {
        resultValue = await unreachableButtonClick(
          Constants.disconnecting,
          caseId.toString(),
          'TELEVT011',
          HttpUrl.unreachableUrl(
            'disconnecting',
            userType.toString(),
          ),
        );
      }
      if (resultValue[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableUnreachableBtnState();
    }
  }

  Future<Map<String, dynamic>> unreachableButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
  ) async {
    var requestBodyData = PhoneUnreachablePostModel(
        eventId: ConstantEventValues.phoneUnreachableEventId,
        eventType: eventType,
        caseId: caseId,
        callerServiceID: Singleton.instance.callerServiceID ?? '',
        callID: Singleton.instance.callID,
        callingID: Singleton.instance.callingID,
        eventCode: eventCode,
        voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
        eventAttr: PhoneUnreachableEventAttr(
          remarks: phoneUnreachableRemarksController.text,
          followUpPriority: 'REVIEW',
          nextActionDate: phoneUnreachableNextActionDateController.text,
        ),
        eventModule: 'Telecalling',
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        contact: PhoneUnreachbleContact(
          cType: caseDetailsAPIValue.result?.callDetails![indexValue!]['cType'],
          value: caseDetailsAPIValue.result?.callDetails![indexValue!]['value'],
          health: ConstantEventValues.phoneUnreachableHealth,
          contactId0: Singleton.instance.contactId_0 ?? '',
        ));
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );
    if (await postResult[Constants.success]) {
      phoneUnreachableNextActionDateController.text = '';
      phoneUnreachableRemarksController.text = '';
      phoneSelectedUnreadableClip = '';

      // Navigator.pop(context);
    } else {}
    return postResult;
  }

  Future<Map<String, dynamic>> customerNotMetButtonClick(
    String eventType,
    String caseId,
    String urlString,
    String followUpPriority,
    dynamic contact,
  ) async {
    Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
    );
    if (Geolocator.checkPermission().toString() !=
        PermissionStatus.granted.toString()) {
      Position res = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      position = res;
    }
    var requestBodyData = CustomerNotMetPostModel(
        eventId: ConstantEventValues.addressCustomerNotMetEventId,
        eventType: eventType,
        caseId: caseId,
        eventCode: ConstantEventValues.addressCustomerNotMetEvenCode,
        contact: contact,
        eventModule: 'Field Allocation',
        callerServiceID: Singleton.instance.callerServiceID ?? '',
        callID: Singleton.instance.callID,
        callingID: Singleton.instance.callingID,
        voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        eventAttr: CustomerNotMetEventAttr(
          remarks: addressCustomerNotMetRemarksController.text,
          followUpPriority: followUpPriority,
          nextActionDate: addressCustomerNotMetNextActionDateController.text,
          longitude: position.longitude,
          latitude: position.latitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          heading: position.heading,
          speed: position.speed,
        ));

    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );

    if (await postResult[Constants.success]) {
      addressCustomerNotMetNextActionDateController.text = '';
      addressCustomerNotMetRemarksController.text = '';
      addressSelectedCustomerNotMetClip = '';

      // Navigator.pop(context);
    } else {}
    return postResult;
  }

  Future<Map<String, dynamic>> addressInvalidButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
    String followUpPriority,
  ) async {
    Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
    );
    if (Geolocator.checkPermission().toString() !=
        PermissionStatus.granted.toString()) {
      Position res = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      position = res;
    }
    var requestBodyData = AddressInvalidPostModel(
        eventId: ConstantEventValues.addressInvalidEventId,
        callerServiceID: Singleton.instance.callerServiceID ?? '',
        callID: Singleton.instance.callID,
        callingID: Singleton.instance.callingID,
        voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        eventAttr: AddressInvalidEventAttr(
          remarks: addressInvalidRemarksController.text,
          followUpPriority: followUpPriority,
          longitude: position.longitude,
          latitude: position.latitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          heading: position.heading,
          speed: position.speed,
        ),
        eventModule: 'Field Allocation',
        contact: [
          AddressInvalidContact(
            cType: caseDetailsAPIValue.result?.addressDetails![indexValue!]
                ['cType'],
            value: caseDetailsAPIValue.result?.addressDetails![indexValue!]
                ['value'],
            health: ConstantEventValues.addressInvalidHealth,
            resAddressId_0: Singleton.instance.resAddressId_0 ?? '',
          )
        ]);
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );

    if (await postResult[Constants.success]) {
      addressInvalidRemarksController.text = '';
      addressSelectedInvalidClip = '';
    }
    return postResult;
  }

  Future<Map<String, dynamic>> phoneInvalidButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
  ) async {
    var requestBodyData = PhoneInvalidPostModel(
        eventId: ConstantEventValues.phoneInvalidEventId,
        eventType: eventType,
        callerServiceID: Singleton.instance.callerServiceID ?? '',
        callID: Singleton.instance.callID,
        callingID: Singleton.instance.callingID,
        voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        caseId: caseId,
        eventCode: eventCode,
        eventAttr: PhoneInvalidEventAttr(
          remarks: phoneInvalidRemarksController.text,
          nextActionDate: DateTime.now().toString(),
        ),
        eventModule: 'Telecalling',
        contact: PhoneInvalidContact(
          cType: caseDetailsAPIValue.result?.callDetails![indexValue!]['cType'],
          value: caseDetailsAPIValue.result?.callDetails![indexValue!]['value'],
          health: ConstantEventValues.phoneInvalidHealth,
          contactId0: Singleton.instance.contactId_0 ?? '',
        ));
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );
    if (await postResult[Constants.success]) {
      phoneInvalidRemarksController.text = '';
      phoneSelectedInvalidClip = '';
    }
    return postResult;
  }
}
