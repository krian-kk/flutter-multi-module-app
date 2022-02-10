import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/phone_invalid_post_model/phone_invalid_post_model.dart';
import 'package:origa/models/phone_unreachable_post_model/phone_unreachable_post_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';

part 'telecaller_phone_event.dart';
part 'telecaller_phone_state.dart';

class TelecallerPhoneBloc
    extends Bloc<TelecallerPhoneEvent, TelecallerPhoneState> {
  List<CustomerMetGridModel> addressCustomerMetGridList = [];
  List<CustomerMetGridModel> phoneCustomerMetGridList = [];
  final phoneInvalidFormKey = GlobalKey<FormState>();
  final phoneUnreachableFormKey = GlobalKey<FormState>();
  FocusNode phoneUnreachableNextActionDateFocusNode = FocusNode();
  FocusNode phoneUnreachableRemarksFocusNode = FocusNode();
  FocusNode phoneInvalidRemarksFocusNode = FocusNode();
  TextEditingController phoneUnreachableNextActionDateController =
      TextEditingController();
  String phoneUnreachableSelectedDate = '';
  String phoneSelectedUnreadableClip = '';
  String phoneSelectedInvalidClip = '';
  TextEditingController phoneUnreachableRemarksController =
      TextEditingController();
  TextEditingController phoneInvalidRemarksController = TextEditingController();
  String? caseId;
  Address? contactValue;

  TelecallerPhoneBloc() : super(TelecallerPhoneInitial()) {
    on<TelecallerPhoneEvent>((event, emit) async {
      if (event is TelecallerInitialPhoneEvent) {
        emit.call(TelecallerPhoneLoadingState());
        caseId = event.caseId;
        contactValue = event.contactValue as Address;

        addressCustomerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp,
              Languages.of(event.context!)!.ptp.toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.ptp, const [], false))),
          CustomerMetGridModel(ImageResource.rtp,
              Languages.of(event.context!)!.rtp.toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.rtp, const [], false))),
          CustomerMetGridModel(ImageResource.dispute,
              Languages.of(event.context!)!.dispute.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.dispute, [], false))),
          CustomerMetGridModel(
              ImageResource.remainder,
              (Languages.of(event.context!)!.remainderCb.toUpperCase())
                  .toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.remainder, [], false))),
          CustomerMetGridModel(ImageResource.collections,
              Languages.of(event.context!)!.collections.toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.collections, [], false))),
          CustomerMetGridModel(ImageResource.ots,
              Languages.of(event.context!)!.ots.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.ots, [], false))),
        ]);

        phoneCustomerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp,
              Languages.of(event.context!)!.ptp.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.ptp, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.rtp,
              Languages.of(event.context!)!.rtp.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.rtp, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.dispute,
              Languages.of(event.context!)!.dispute.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.dispute, [], true)),
              isCall: true),
          CustomerMetGridModel(
              ImageResource.remainder,
              (Languages.of(event.context!)!.remainderCb.toUpperCase())
                  .toUpperCase()
                  .toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.remainder, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.collections,
              Languages.of(event.context!)!.collections.toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.collections, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.ots, Constants.ots,
              onTap: () => add(ClickOpenBottomSheetEvent(
                  Languages.of(event.context!)!.ots.toUpperCase(), [], true)),
              isCall: true),
        ]);
        emit.call(TelecallerPhoneLoadedState());
      }
      if (event is ClickOpenBottomSheetEvent) {
        // switch (event.title) {
        // case Constants.eventDetails:
        // if (ConnectivityResult.none ==
        //     await Connectivity().checkConnectivity()) {
        //   yield CDNoInternetState();
        // } else {
        // Map<String, dynamic> getEventDetailsData =
        //     await APIRepository.apiRequest(
        //         APIRequestType.GET,
        //         HttpUrl.eventDetailsUrl(
        //             caseId: caseId, userType: userType));

        // if (getEventDetailsData[Constants.success] == true) {
        //   Map<String, dynamic> jsonData = getEventDetailsData['data'];

        //   eventDetailsAPIValue = EventDetailsApiModel.fromJson(jsonData);
        // print(getEventDetailsData['data']['result'][3]['eventAttr']);

        // eventDetailsHiveBox.then((value) => value.put(
        //     'EventDetails1',
        //     OrigoDynamicTable(
        //       status: jsonData['status'],
        //       message: jsonData['message'],
        //       result: jsonData['result'],
        //     )));
        //   } else {
        //     AppUtils.showToast(getEventDetailsData['data']['message']);
        //   }
        // }
        // await eventDetailsHiveBox.then((value) {
        //   value.get('EventDetails1')?.result.forEach((element) {
        //     offlineEventDetailsListValue.add(EventDetailsResultModel.fromJson(
        //         Map<String, dynamic>.from(element)));
        //   })
        // });
        // break;
        // case Constants.otherFeedback:
        // if (ConnectivityResult.none ==
        //     await Connectivity().checkConnectivity()) {
        //   yield NoInternetState();
        // } else {
        //   Map<String, dynamic> getContractorDetails =
        //       await APIRepository.apiRequest(
        //           APIRequestType.GET, HttpUrl.contractorDetail);
        //   if (getContractorDetails[Constants.success] == true) {
        //     Map<String, dynamic> jsonData = getContractorDetails['data'];
        //     contractorDetailsValue =
        //         ContractorDetailsModel.fromJson(jsonData);
        //   } else {
        //     AppUtils.showToast(getContractorDetails['data'] ?? '');
        //     // AppUtils.showToast(getContractorDetails['data']);
        //   }
        // }
        // break;
        // default:
        // }

        emit.call(TcClickOpenBottomSheetState(
            event.title, event.list!, event.isCall,
            health: event.health));
      }
      if (event is ClickTcPhoneInvalidButtonEvent) {
        emit.call(TcDisablePhoneInvalidBtnState());
        late Map<String, dynamic> resultValue = {Constants.success: false};
        if (phoneInvalidFormKey.currentState!.validate()) {
          if (phoneSelectedInvalidClip != '') {
            if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.doesNotExist) {
              resultValue = await phoneInvalidButtonClick(
                  Constants.doesNotExist,
                  caseId.toString(),
                  HttpUrl.numberNotWorkingUrl(
                      'doesNotExist', Singleton.instance.usertype!));
            } else if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.incorrectNumber) {
              resultValue = await phoneInvalidButtonClick(
                Constants.incorrectNumber,
                caseId.toString(),
                HttpUrl.incorrectNumberUrl(
                    'incorrectNo', Singleton.instance.usertype!),
              );
            } else if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.numberNotWorking) {
              resultValue = await phoneInvalidButtonClick(
                Constants.numberNotWorking,
                caseId.toString(),
                HttpUrl.numberNotWorkingUrl(
                    'numberNotWorking', Singleton.instance.usertype!),
              );
            } else if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.notOperational) {
              resultValue = await phoneInvalidButtonClick(
                  Constants.notOpeartional,
                  caseId.toString(),
                  HttpUrl.notOperationalUrl(
                      'notOperational', Singleton.instance.usertype!));
            }
          } else {
            AppUtils.showToast(Constants.pleaseSelectOptions);
          }
        }
        if (resultValue[Constants.success]) {
          // if (isAutoCalling) {
          //   allocationBloc.add(StartCallingEvent(
          //     customerIndex: paramValue['customerIndex'],
          //     phoneIndex: paramValue['phoneIndex'] + 1,
          //     // customerList: widget.bloc.allocationBloc
          //     //     .resultList[(widget.bloc
          //     //         .paramValue['customerIndex']) +
          //     //     1],
          //   ));
          //   Navigator.pop(paramValue['context']);
          // }
          // emit.call( UpdateHealthStatusState());

          // update autocalling screen case list of contact health
          // if (paramValue['contactIndex'] != null) {
          //   print("update autocalling screen case list of contact health");
          //   allocationBloc.add(AutoCallContactHealthUpdateEvent(
          //     contactIndex: paramValue['contactIndex'],
          //     caseIndex: paramValue['caseIndex'],
          //   ));
          // }

          emit.call(TcPostDataApiSuccessState());
        }
        emit.call(TcEnablePhoneInvalidBtnState());
      }
      if (event is ClickTcPhoneUnreachableSubmitedButtonEvent) {
        emit.call(TcDisableUnreachableBtnState());
        late Map<String, dynamic> resultValue;
        if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.lineBusy) {
          resultValue = await unreachableButtonClick(
            Constants.lineBusy,
            caseId.toString(),
            ConstantEventValues.lineBusyEvenCode,
            HttpUrl.unreachableUrl(
              'lineBusy',
              Singleton.instance.usertype!,
            ),
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.switchOff) {
          resultValue = await unreachableButtonClick(
            Constants.switchOff,
            caseId.toString(),
            ConstantEventValues.switchOffEvenCode,
            HttpUrl.unreachableUrl(
              'switchOff',
              Singleton.instance.usertype!,
            ),
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.rnr) {
          resultValue = await unreachableButtonClick(
            Constants.rnr,
            caseId.toString(),
            ConstantEventValues.rnrEvenCode,
            HttpUrl.unreachableUrl(
              'RNR',
              Singleton.instance.usertype!,
            ),
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.outOfNetwork) {
          resultValue = await unreachableButtonClick(
            Constants.outOfNetwork,
            caseId.toString(),
            ConstantEventValues.outOfNetworkEvenCode,
            HttpUrl.unreachableUrl(
              'outOfNetwork',
              Singleton.instance.usertype!,
            ),
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.disConnecting) {
          resultValue = await unreachableButtonClick(
            Constants.disconnecting,
            caseId.toString(),
            ConstantEventValues.disConnectingEvenCode,
            HttpUrl.unreachableUrl(
              'disconnecting',
              Singleton.instance.usertype!,
            ),
          );
        }
        if (resultValue[Constants.success]) {
          // if (userType == Constants.telecaller) {
          //   isEventSubmited = true;
          //   caseDetailsAPIValue.result?.caseDetails?.collSubStatus = 'used';
          // }
          // if (isAutoCalling) {
          //   allocationBloc.add(StartCallingEvent(
          //     customerIndex: paramValue['customerIndex'],
          //     phoneIndex: paramValue['phoneIndex'] + 1,
          //   ));
          //   // Navigator.pop(paramValue['context']);
          // }

          // emit.call( UpdateHealthStatusState());

          // if (paramValue['contactIndex'] != null) {
          //   print("update autocalling screen case list of contact health");
          //   allocationBloc.add(AutoCallContactHealthUpdateEvent(
          //     contactIndex: paramValue['contactIndex'],
          //     caseIndex: paramValue['caseIndex'],
          //   ));
          // }
          emit.call(TcPostDataApiSuccessState());
        }
        emit.call(TcEnableUnreachableBtnState());
      }
    });
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
          nextActionDate: phoneUnreachableSelectedDate != ''
              ? phoneUnreachableSelectedDate
              : phoneUnreachableNextActionDateController.text,
        ),
        eventModule: 'Telecalling',
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        contractor: Singleton.instance.contractor ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        contact: PhoneUnreachbleContact(
          cType: contactValue!.cType!,
          value: contactValue!.value!,
          health: ConstantEventValues.phoneUnreachableHealth,
          contactId0: Singleton.instance.contactId_0 ?? '',
        ));
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );
    if (await postResult[Constants.success]) {
      phoneUnreachableSelectedDate = '';
      phoneUnreachableNextActionDateController.text = '';
      phoneUnreachableRemarksController.text = '';
      phoneSelectedUnreadableClip = '';
    } else {}
    return postResult;
  }

  Future<Map<String, dynamic>> phoneInvalidButtonClick(
    String eventType,
    String caseId,
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
        contractor: Singleton.instance.contractor ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        caseId: caseId,
        eventCode: ConstantEventValues.phoneInvalidEvenCode,
        eventAttr: PhoneInvalidEventAttr(
          remarks: phoneInvalidRemarksController.text,
          nextActionDate: DateTime.now().toString(),
        ),
        eventModule: 'Telecalling',
        contact: PhoneInvalidContact(
          cType: contactValue!.cType!,
          value: contactValue!.value!,
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
