import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/address_invalid_post_model/address_invalid_post_model.dart';
import 'package:origa/models/case_details_api_model/result.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/customer_not_met_post_model/customer_not_met_post_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/event_details_api_model/result.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/models/phone_invalid_post_model/phone_invalid_post_model.dart';
import 'package:origa/models/phone_unreachable_post_model/phone_unreachable_post_model.dart';
import 'package:origa/offline_helper/dynamic_table.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  String? caseId;

  int? indexValue;
  String? userType;

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

      caseId = event.paramValues['caseID'];

      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString('userType');

      //check internet
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        yield NoInternetState();
      } else {
        Map<String, dynamic> caseDetailsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.caseDetailsUrl + 'caseId=$caseId');

        if (caseDetailsData['success'] == true) {
          Map<String, dynamic> jsonData = caseDetailsData['data'];

          caseDetailsHiveBox.then((value) => value.put(
              'c1',
              OrigoMapDynamicTable(
                status: jsonData['status'],
                message: jsonData['message'],
                result: jsonData['result'],
              )));
        } else {}
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

      addressCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, Constants.ptp,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.ptp, offlineCaseDetailsValue.addressDetails!))),
        CustomerMetGridModel(ImageResource.rtp, Constants.rtp,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.rtp, offlineCaseDetailsValue.addressDetails!))),
        CustomerMetGridModel(ImageResource.dispute, Constants.dispute,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.dispute, offlineCaseDetailsValue.addressDetails!))),
        CustomerMetGridModel(ImageResource.remainder, Constants.remainder,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.remainder, offlineCaseDetailsValue.addressDetails!))),
        CustomerMetGridModel(ImageResource.collections, Constants.collections,
            onTap: () => add(ClickOpenBottomSheetEvent(Constants.collections,
                offlineCaseDetailsValue.addressDetails!))),
        CustomerMetGridModel(ImageResource.ots, Constants.ots,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.ots, offlineCaseDetailsValue.addressDetails!))),
      ]);

      expandOtherFeedback.addAll([
        OtherFeedbackExpandModel(header: 'ABC', subtitle: 'subtitle'),
        OtherFeedbackExpandModel(
            header: 'VEHICLE AVAILABLE', subtitle: 'subtitle'),
        OtherFeedbackExpandModel(
            header: 'COLLECTOR FEEDDBACK', subtitle: 'subtitle'),
      ]);
      phoneCustomerMetGridList.addAll([
        CustomerMetGridModel(ImageResource.ptp, Constants.ptp,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.ptp, offlineCaseDetailsValue.callDetails!))),
        CustomerMetGridModel(ImageResource.rtp, Constants.rtp,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.rtp, offlineCaseDetailsValue.callDetails!))),
        CustomerMetGridModel(ImageResource.dispute, Constants.dispute,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.dispute, offlineCaseDetailsValue.callDetails!))),
        CustomerMetGridModel(ImageResource.remainder, Constants.remainder,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.remainder, offlineCaseDetailsValue.callDetails!))),
        CustomerMetGridModel(ImageResource.collections, Constants.collections,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.collections, offlineCaseDetailsValue.callDetails!))),
        CustomerMetGridModel(ImageResource.ots, Constants.ots,
            onTap: () => add(ClickOpenBottomSheetEvent(
                Constants.ots, offlineCaseDetailsValue.callDetails!))),
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
                        caseId: '5f80375a86527c46deba2e62',
                        usertype: 'TELECALLER')
                    // + '5f80375a86527c46deba2e62'
                    );

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

      yield ClickOpenBottomSheetState(event.title, event.list!);
    }

    if (event is PostImageCapturedEvent) {
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.imageCaptured + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is ClickCustomerNotMetButtonEvent) {
      late Map<String, dynamic> resultValue;
      if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.leftMessage) {
        resultValue = await customerNotMetButtonClick(
          Constants.leftMessage,
          caseId.toString(),
          'TELEVT007',
          HttpUrl.leftMessageUrl(
            'leftMessage',
            'FIELDAGENT',
          ),
          'PTP',
          {
            'cType': offlineCaseDetailsValue.addressDetails?[indexValue!]
                    ['cType']
                .toString(),
            'value': offlineCaseDetailsValue.addressDetails?[indexValue!]
                    ['value']
                .toString(),
            'health': '1'
          },
        );
      } else if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.doorLocked) {
        resultValue = await customerNotMetButtonClick(
          Constants.doorLocked,
          caseId.toString(),
          'TELEVT007',
          HttpUrl.doorLockedUrl('doorLocked', 'FIELDAGENT'),
          'NEW',
          [
            {
              'cType': offlineCaseDetailsValue.addressDetails?[indexValue!]
                      ['cType']
                  .toString(),
              'value': offlineCaseDetailsValue.addressDetails?[indexValue!]
                      ['value']
                  .toString(),
              'health': '1'
            }
          ],
        );
      } else if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.entryRestricted) {
        resultValue = await customerNotMetButtonClick(
          Constants.entryRestricted,
          caseId.toString(),
          'TELEVT007',
          HttpUrl.entryRestrictedUrl('entryRestricted', 'FIELDAGENT'),
          'PTP',
          [
            {
              'cType': offlineCaseDetailsValue.addressDetails?[indexValue!]
                      ['cType']
                  .toString(),
              'value': offlineCaseDetailsValue.addressDetails?[indexValue!]
                      ['value']
                  .toString(),
              'health': '1'
            }
          ],
        );
      }
      if (resultValue['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is ClickAddressInvalidButtonEvent) {
      late Map<String, dynamic> resultValue = {'success': false};
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
                'FIELDAGENT',
              ),
              'PTP',
            );
          } else if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.shifted) {
            resultValue = await addressInvalidButtonClick(
                Constants.shifted,
                caseId.toString(),
                'TELEVT008',
                HttpUrl.shiftedUrl('shifted', 'FIELDAGENT'),
                'REVIEW');
          } else if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.addressNotFound) {
            resultValue = await addressInvalidButtonClick(
              Constants.addressNotFound,
              caseId.toString(),
              'TELEVT008',
              HttpUrl.addressNotFoundUrl(
                'addressNotFound',
                'FIELDAGENT',
              ),
              'PTP',
            );
          }
        } else {
          AppUtils.showToast(Constants.pleaseSelectOptions);
        }
      }
      if (resultValue['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is ClickPhoneInvalidButtonEvent) {
      late Map<String, dynamic> resultValue = {'success': false};
      if (phoneInvalidFormKey.currentState!.validate()) {
        if (phoneSelectedInvalidClip != '') {
          if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.doesNotExist) {
            resultValue = await phoneInvalidButtonClick(
                'TC : Does Not Exist',
                caseId.toString(),
                'TELEVT008',
                HttpUrl.numberNotWorkingUrl('doesNotExist', 'TELECALLER'));
          } else if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.incorrectNumber) {
            resultValue = await phoneInvalidButtonClick(
              'TC : Incorrect Number',
              caseId.toString(),
              'TELEVT008',
              HttpUrl.incorrectNumberUrl('incorrectNo', 'TELECALLER'),
            );
          } else if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.numberNotWorking) {
            resultValue = await phoneInvalidButtonClick(
              'TC : Number Not Working',
              caseId.toString(),
              'TELEVT008',
              HttpUrl.numberNotWorkingUrl('numberNotWorking', 'TELECALLER'),
            );
          } else if (phoneSelectedInvalidClip ==
              Languages.of(event.context)!.notOperational) {
            resultValue = await phoneInvalidButtonClick(
                'TC : Not Operational',
                caseId.toString(),
                'TELEVT008',
                HttpUrl.notOperationalUrl('notOperational', 'TELECALLER'));
          }
        } else {
          AppUtils.showToast(Constants.pleaseSelectOptions);
        }
      }
      if (resultValue['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is ClickPhoneUnreachableSubmitedButtonEvent) {
      late Map<String, dynamic> resultValue;
      if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.lineBusy) {
        resultValue = await unreachableButtonClick(
          'TC : Line Busy',
          caseId.toString(),
          'TELEVT007',
          HttpUrl.unreachableUrl(
            'lineBusy',
            'TELECALLER',
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.switchOff) {
        resultValue = await unreachableButtonClick(
          'TC : Switch Off',
          caseId.toString(),
          'TELEVT007',
          HttpUrl.unreachableUrl(
            'switchOff',
            'TELECALLER',
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.rnr) {
        resultValue = await unreachableButtonClick(
          'TC : RNR',
          caseId.toString(),
          'TELEVT011',
          HttpUrl.unreachableUrl(
            'RNR',
            'TELECALLER',
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.outOfNetwork) {
        resultValue = await unreachableButtonClick(
          'TC : Out Of Network',
          caseId.toString(),
          'TELEVT007',
          HttpUrl.unreachableUrl(
            'outOfNetwork',
            'TELECALLER',
          ),
        );
      } else if (phoneSelectedUnreadableClip ==
          Languages.of(event.context)!.disConnecting) {
        resultValue = await unreachableButtonClick(
          'TC : Disconnecting',
          caseId.toString(),
          'TELEVT011',
          HttpUrl.unreachableUrl(
            'disconnecting',
            'TELECALLER',
          ),
        );
      }
      if (resultValue['success']) {
        yield PostDataApiSuccessState();
      }
    }
  }

  Future<Map<String, dynamic>> unreachableButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
  ) async {
    var requestBodyData = PhoneUnreachablePostModel(
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        eventAttr: PhoneUnreachableEventAttr(
            remarks: phoneUnreachableRemarksController.text,
            followUpPriority: 'REVIEW',
            nextActionDate: phoneUnreachableNextActionDateController.text),
        contact: PhoneUnreachbleContact(
          cType: offlineCaseDetailsValue.callDetails![indexValue!]['cType'],
          value: offlineCaseDetailsValue.callDetails![indexValue!]['value'],
        ));
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );
    if (await postResult['success']) {
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
    String eventCode,
    String urlString,
    String followUpPriority,
    dynamic contact,
  ) async {
    var requestBodyData = CustomerNotMetPostModel(
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        contact: contact,
        eventAttr: CustomerNotMetEventAttr(
            remarks: addressCustomerNotMetRemarksController.text,
            followUpPriority: followUpPriority,
            nextActionDate: addressCustomerNotMetNextActionDateController.text,
            agentLocation: CustomerNotMetAgentLocation()));

    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );

    if (await postResult['success']) {
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
    var requestBodyData = AddressInvalidPostModel(
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        eventAttr: AddressInvalidEventAttr(
            remarks: addressInvalidRemarksController.text,
            followUpPriority: followUpPriority,
            agentLocation: AgentLocation()),
        contact: [
          AddressInvalidContact(
            cType: offlineCaseDetailsValue.addressDetails![indexValue!]
                ['cType'],
            value: offlineCaseDetailsValue.addressDetails![indexValue!]
                ['value'],
          )
        ]);
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );

    if (await postResult['success']) {
      addressInvalidRemarksController.text = '';
      addressSelectedInvalidClip = '';

      // Navigator.pop(context);
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
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        eventAttr: PhoneInvalidEventAttr(
            remarks: phoneInvalidRemarksController.text,
            nextActionDate: DateTime.now().toString()),
        contact: PhoneInvalidContact(
          cType: offlineCaseDetailsValue.callDetails![indexValue!]['cType'],
          value: offlineCaseDetailsValue.callDetails![indexValue!]['value'],
        ));
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );
    if (await postResult['success']) {
      phoneInvalidRemarksController.text = '';
      phoneSelectedInvalidClip = '';

      // Navigator.pop(context);
    }
    return postResult;
  }
}
