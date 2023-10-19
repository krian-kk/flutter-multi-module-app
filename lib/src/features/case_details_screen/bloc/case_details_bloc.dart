import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:design_system/constants.dart';
import 'package:dio/dio.dart';
import 'package:domain_models/common/constant_event_values.dart';
import 'package:domain_models/response_models/case/case_detail_models/case_details_response.dart';
import 'package:domain_models/response_models/events/event_details/event_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:languages/app_languages.dart';
import 'package:languages/language_english.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:origa/models/campaign_config_model.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/customer_not_met_post_model/customer_not_met_post_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/event_details_model/display_eventdetails_model.dart';
import 'package:origa/models/event_details_model/event_details_model.dart';
import 'package:origa/models/imagecaptured_post_model.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/models/play_audio_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/send_whatsapp_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/language_to_constant_convert.dart';
import 'package:repository/case_repository.dart';

part 'case_details_event.dart';

part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  CaseDetailsBloc(this.caseRepository) : super(CaseDetailsInitial()) {
    on<CaseDetailsEvent>(_onEvent);
  }

  CaseRepository caseRepository;

  //Offline purpose
  dynamic selectedAddressModel;

  String? caseId;
  String? custName;
  String? agentName;
  bool isEventSubmitted = false;
  bool isSubmittedForMyVisits = false;
  String submittedEventType = '';
  dynamic collectionAmount;
  bool isAutoCalling = false;
  String? changeFollowUpDate;
  bool isSendWhatsappLoading = false;
  bool isEventSubmited = false;
  bool isSubmitedForMyVisits = false;
  String submitedEventType = '';
  BuildContext? caseDetailsContext;
  bool isBasicInfo = true;

  //Event Detail model
  List<EventModel> eventList = [];
  Map releaseDateMap = {};
  List<EventDetailsResultsModel> eventDetailsAPIValues = [];
  List<EventDetailsPlayAudioModel> eventDetailsPlayAudioModel =
      <EventDetailsPlayAudioModel>[];
  List<EventResult> displayEventDetail = [];
  bool isEventDetailLoading = false;

  int? indexValue;
  String? userType;
  dynamic paramValue;

  // Online Purpose
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';
  CaseDetailsResultModel caseDetailsAPIValue = CaseDetailsResultModel();
  SendWhatsappModel sendwhatsappModel = SendWhatsappModel();
  CampaignConfigModel campaingnConfigModel = CampaignConfigModel();

  // Address Details Screen
  String addressSelectedCustomerNotMetClip = '';
  String addressSelectedInvalidClip = '';

  final GlobalKey<FormState> addressCustomerNotMetFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> addressInvalidFormKey = GlobalKey<FormState>();

  TextEditingController addressInvalidRemarksController =
      TextEditingController();
  TextEditingController addressCustomerNotMetNextActionDateController =
      TextEditingController();
  String addressCustomerNotMetSelectedDate = '';
  TextEditingController addressCustomerNotMetRemarksController =
      TextEditingController();
  FocusNode addressInvalidRemarksFocusNode = FocusNode();
  FocusNode addressCustomerNotMetNextActionDateFocusNode = FocusNode();
  FocusNode addressCustomerNotMetRemarksFocusNode = FocusNode();

  List<CustomerMetGridModel> addressCustomerMetGridList =
      <CustomerMetGridModel>[];
  List<OtherFeedbackExpandModel> expandOtherFeedback =
      <OtherFeedbackExpandModel>[];
  List<EventExpandModel> expandEvent = <EventExpandModel>[];

  Speech2TextModel returnS2TCustomerNotMet = Speech2TextModel();
  String? isRecordCustomerNotMet;
  String translateTextCustomerNotMet = '';
  bool isTranslateCustomerNotMet = true;

  Speech2TextModel returnS2TAddressInvalid = Speech2TextModel();
  String? isRecordAddressInvaild;
  String translateTextAddressInvalid = '';
  bool isTranslateAddressInvalid = true;

  Speech2TextModel returnS2TUnReachable = Speech2TextModel();
  String? isRecordUnReachable;
  String translateTextUnReachable = '';
  bool isTranslateUnReachable = true;

  Speech2TextModel returnS2TPhoneInvalid = Speech2TextModel();
  String? isRecordPhoneInvalid;
  String translateTextPhoneInvalid = '';
  bool isTranslatePhoneInvalid = true;

  // Phone Details screen
  String phoneSelectedUnreadableClip = '';
  String phoneSelectedInvalidClip = '';
  List<CustomerMetGridModel> phoneCustomerMetGridList =
      <CustomerMetGridModel>[];

  final GlobalKey<FormState> phoneUnreachableFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneInvalidFormKey = GlobalKey<FormState>();

  TextEditingController phoneUnreachableNextActionDateController =
      TextEditingController();
  String phoneUnreachableSelectedDate = '';
  TextEditingController phoneUnreachableRemarksController =
      TextEditingController();
  TextEditingController phoneInvalidRemarksController = TextEditingController();

  FocusNode phoneUnreachableNextActionDateFocusNode = FocusNode();
  FocusNode phoneUnreachableRemarksFocusNode = FocusNode();
  FocusNode phoneInvalidRemarksFocusNode = FocusNode();

//store list off Address
  List<dynamic>? listOfAddressDetails = <dynamic>[];

//store list off Mobile no
  List<dynamic>? listOfCallDetails = <dynamic>[];
  List<Address>? listOfAddress;

// Repayment info send sms loading
  bool isSendSMSloading = false;

// its used to show QR button in Customer met screen
  bool isShowQRcode = false;
  bool isQRcodeBtnLoading = false;

// its used to GeneratePaymentLink button in Case detail screen
  bool isGeneratePaymentLink = false;
  bool isGeneratePaymentLinkLoading = false;
  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  Future<FutureOr<void>> _onEvent(
      CaseDetailsEvent event, Emitter<CaseDetailsState> emit) async {
    userType = 'FIELDAGENT';
    if (event is CaseDetailsInitialEvent) {
      emit(CaseDetailsLoadingState());
      caseDetailsContext = event.context;
      // Singleton.instance.buildContext = event.context;
      caseId = event.paramValues['caseID'];
      paramValue = event.paramValues;
      listOfAddress = event.paramValues['mobileList'];
      // check internet
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        //todo offline code
      } else {
        isNoInternetAndServerError = false;
        debugPrint(caseId);
        final ApiResult<CaseDetailsResultModel> dashBoardData =
            await caseRepository.getCasesDetailsFromServer(
                event.paramValues['caseID'].toString());
        await dashBoardData.when(
            success: (CaseDetailsResultModel? result) async {
              caseDetailsAPIValue = result!;
              caseDetailsAPIValue.callDetails = result.callDetails;
              caseDetailsAPIValue.callDetails?.sort((dynamic a, dynamic b) =>
                  (b['health'] ?? '1.5').compareTo(a['health'] ?? '1.5'));
              // Singleton.instance.caseCustomerName =
              //     caseDetailsAPIValue.result?.caseDetails?.cust ?? '';
              final List<ContactType> contactTemplate = [];
              caseDetailsAPIValue.availableAddContacts?.forEach((element) {
                contactTemplate.add(
                    ContactType(cType: element.cType, name: element.cName));
              });
              Singleton.instance.availableAddContacts = contactTemplate;
              debugPrint(
                  'screen${Singleton.instance.availableAddContacts.length}');
              emit(CaseDetailsLoadedState());
            },
            failure: (NetworkExceptions? error) async {});
        //
        // if (caseDetailsData[Constants.success] == true) {
        // } else if (caseDetailsData['statusCode'] == 401 ||
        //     caseDetailsData['statusCode'] == 502) {
        //   isNoInternetAndServerError = true;
        //   noInternetAndServerErrorMsg = caseDetailsData['data'];
        // }
      }

      Singleton.instance.overDueAmount =
          caseDetailsAPIValue.caseDetails?.odVal.toString() ?? '';
      Singleton.instance.agrRef = caseDetailsAPIValue.caseDetails?.agrRef ?? '';

      // Clear the lists
      listOfAddressDetails?.clear();
      listOfCallDetails?.clear();
      //Stor list of address
      listOfAddressDetails = caseDetailsAPIValue.addressDetails ?? [];
      //Stor list of contacts (mobile Numbers)
      listOfCallDetails = caseDetailsAPIValue.callDetails ?? [];

      addressCustomerMetGridList.addAll(<CustomerMetGridModel>[
        CustomerMetGridModel(ImageResource.ptp, LanguageEn().ptp.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                Constants.ptp, caseDetailsAPIValue.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.rtp, LanguageEn().rtp.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                Constants.rtp, caseDetailsAPIValue.addressDetails!, false))),
        CustomerMetGridModel(
            ImageResource.dispute, LanguageEn().dispute.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.dispute,
                caseDetailsAPIValue.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.remainder,
            (LanguageEn().remainderCb.toUpperCase()).toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.remainder,
                caseDetailsAPIValue.addressDetails!, false))),
        CustomerMetGridModel(
            ImageResource.collections, LanguageEn().collections.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.collections,
                caseDetailsAPIValue.addressDetails!, false))),

        // // otsEnable is true means show OTS button otherwise dont show
        // // 'otsEnable' value get from contractor details
        // if (Singleton.instance.contractorInformations?.result?.otsEnable ==
        //     true)
        CustomerMetGridModel(ImageResource.ots, LanguageEn().ots.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                Constants.ots, caseDetailsAPIValue.addressDetails!, false))),
      ]);

      // Customer Not met Next Action Date is = Current Date + 3 days
      addressCustomerNotMetNextActionDateController.text =
          DateFormat('yyyy-MM-dd')
              .format(DateTime.now().add(const Duration(days: 3)));
      // Unreachable Next Action Date is = Current Date + 1 days
      phoneUnreachableNextActionDateController.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(const Duration(days: 1)));

      //todo check payment config
      // // Check Payment Configuartion Details and store the value of dynamicLink [isGeneratePaymentLink] and qrCode [isShowQRcode]
      // if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      //   PaymentConfigurationModel paymentCofigurationData =
      //       PaymentConfigurationModel();
      //   final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      //       APIRequestType.get, HttpUrl.getPaymentConfiguration,
      //       encrypt: false);
      //   if (postResult[Constants.success]) {
      //     paymentCofigurationData =
      //         PaymentConfigurationModel.fromJson(postResult['data']);
      //     debugPrint(jsonEncode(paymentCofigurationData));
      //
      //     if (paymentCofigurationData.data?.isNotEmpty == true) {
      //       final List<Payment>? paymentList =
      //           paymentCofigurationData.data?[0].payment;
      //       if (paymentList != null && paymentList.isNotEmpty == true) {
      //         isShowQRcode = paymentList[0].qrCode ?? false;
      //         isGeneratePaymentLink = paymentList[0].dynamicLink ?? false;
      //       }
      //     } else {
      //       AppUtils.showToast('The payment data is empty');
      //     }
      //   }
      // }

      //todo Send Whatsapp button showing based on whatsapp api key
      // if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      //   final Map<String, dynamic> getCampaignConfig =
      //       await APIRepository.apiRequest(
      //           APIRequestType.get, HttpUrl.campaignConfig,
      //           encrypt: true);
      //   if (getCampaignConfig[Constants.success] == true) {
      //     try {
      //       campaingnConfigModel =
      //           CampaignConfigModel.fromJson(getCampaignConfig['data']);
      //       debugPrint(
      //           '-----whatsapp key----- ${campaingnConfigModel.result!.whatsappApiKey}');
      //     } catch (e) {
      //       debugPrint(e.toString());
      //     }
      //   }
      // } else {
      //   AppUtils.noInternetSnackbar(event.context!);
      // }

      if (event.paramValues['isAutoCalling'] != null) {
        isAutoCalling = true;
        // indexValue = allocationBloc.indexValue;
        // yield ClickMainCallBottomSheetState(0);
        emit(PhoneBottomSheetSuccessState());
      }
    }
    if (event is EventDetailsEvent) {
      emit(CaseDetailsLoadingState());
      if (isAutoCalling || paramValue['contactIndex'] != null) {
        // openBottomSheet(caseDetailsContext!, event.title,
        //     event.list ?? <dynamic>[], event.isCall);
      } else {
        debugPrint("line 664------->${event.isCall}");
        if (event.title == Constants.callCustomer &&
            Singleton.instance.cloudTelephony == false) {
          await AppUtils.makePhoneCall(event.seleectedContactNumber.toString());
          emit(CaseDetailsLoadedState());
        } else {
          debugPrint('line 693------->${event.list?.length}');
          emit(ClickOpenBottomSheetState(
            event.title,
            event.list!,
            event.isCall,
            health: event.health,
            selectedContactNumber: event.seleectedContactNumber,
            isCallFromCallDetails: event.isCallFromCallDetails,
            callId: event.callId,
          ));
        }
      }
    }
    if (event is TriggerEventDetailsEvent) {
      isEventDetailLoading = true;
      //Event details API
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        //todo to put firebase code
      } else {
        final ApiResult<List<EventDetailsResultsModel>> dashBoardData =
            await caseRepository.getEventDetailsFromServer(caseId ?? '');
        await dashBoardData.when(
            success: (List<EventDetailsResultsModel>? result) async {
              eventDetailsAPIValues = result!;
              eventDetailsAPIValues.sort((a, b) {
                return a.createdAt
                    .toString()
                    .toLowerCase()
                    .compareTo(b.createdAt.toString().toLowerCase());
              });
              releaseDateMap =
                  eventDetailsAPIValues.groupBy((m) => m.monthName);
              final List<Map> data = [];
              releaseDateMap.forEach((key, value) {
                // debugPrint('key--> $key value--> ${value}');
                final map = {
                  'month': key,
                  'eventList': value,
                };
                data.add(jsonDecode(jsonEncode(map)));
              });
              final eventList = data
                  .map((item) =>
                      EventResult.fromJson(item as Map<String?, dynamic>))
                  .toList()
                  .reversed
                  .toList();

              emit(TriggerEventDetailsState(eventListData: eventList));
            },
            failure: (NetworkExceptions? error) async {});
      }
    }
    if (event is ClickMainAddressBottomSheetEvent) {
      indexValue = event.index;
      emit(ClickMainAddressBottomSheetState(event.index,
          addressModel: event.addressModel));
    }

    if (event is ChangeFollowUpDateEvent) {
      changeFollowUpDate = event.followUpDate;
    }
    if (event is PostImageCapturedEvent) {
      emit(DisableCaptureImageBtnState());
      final Map<String, dynamic> postData =
          jsonDecode(jsonEncode(event.postData!.toJson()))
              as Map<String, dynamic>;
      final List<dynamic> value = <dynamic>[];
      for (File element in event.fileData!) {
        value.add(await MultipartFile.fromFile(element.path.toString()));
      }
      postData.addAll(<String, dynamic>{
        'files': value,
      });

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        //do do do do
        final Map<String, dynamic> firebaseObject = event.postData!.toJson();
        try {
          firebaseObject.addAll(
              await FirebaseUtils.toPrepareFileStoringModel(event.fileData!));
        } catch (e) {
          debugPrint('Exception while converting base64 ${e.toString()}');
        }
        await FirebaseUtils.storeEvents(
            eventsDetails: firebaseObject, caseId: caseId, bloc: this);
        emit(PostDataApiSuccessState());
      } else {
        final CaseRepositoryImpl caseRepositoryImpl = CaseRepositoryImpl();
        final ApiResult<BaseResponse> eventResult = await caseRepositoryImpl
            .postImageCaptureEvent(FormData.fromMap(postData));
        await eventResult.when(
            success: (BaseResponse? result) async {
              if (Singleton.instance.usertype == Constants.fieldagent &&
                  Singleton.instance.isOfflineEnabledContractorBased) {
                //do do do do
                final Map<String, dynamic> firebaseObject =
                    event.postData!.toJson();
                try {
                  firebaseObject.addAll(
                      await FirebaseUtils.toPrepareFileStoringModel(
                          event.fileData!));
                } catch (e) {
                  debugPrint(
                      'Exception while converting base64 ${e.toString()}');
                }
                await FirebaseUtils.storeEvents(
                    eventsDetails: firebaseObject, caseId: caseId, bloc: this);
              }
              Navigator.pop(event.context!);
              emit(PostDataApiSuccessState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      emit(EnableCaptureImageBtnState());
    }

    if (event is ClickCustomerNotMetButtonEvent) {
      emit(DisableCustomerNotMetBtnState());
      if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)?.leftMessage) {
        customerNotMetButtonClick(
            Constants.leftMessage,
            caseId.toString(),
            'leftMessage',
            'PTP',
            <String, dynamic>{
              'cType': caseDetailsAPIValue.addressDetails?[indexValue!]['cType']
                  .toString(),
              'value': caseDetailsAPIValue.addressDetails?[indexValue!]['value']
                  .toString(),
              'health': ConstantEventValues.addressCustomerNotMetHealth,
              // 'resAddressId_0': Singleton.instance.resAddressId_0,
            },
            addressSelectedCustomerNotMetClip,
            event.context,
            emit);
      } else if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.doorLocked) {
        customerNotMetButtonClick(
            Constants.doorLocked,
            caseId.toString(),
            'doorLocked',
            'PTP',
            <String, dynamic>{
              'cType': caseDetailsAPIValue.addressDetails?[indexValue!]['cType']
                  .toString(),
              'value': caseDetailsAPIValue.addressDetails?[indexValue!]['value']
                  .toString(),
              'health': ConstantEventValues.addressCustomerNotMetHealth,
              // 'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
            },
            addressSelectedCustomerNotMetClip,
            event.context,
            emit);
      } else if (addressSelectedCustomerNotMetClip ==
          Languages.of(event.context)!.entryRestricted) {
        customerNotMetButtonClick(
            Constants.entryRestricted,
            caseId.toString(),
            'entryRestricted',
            'PTP',
            <String, dynamic>{
              'cType': caseDetailsAPIValue.addressDetails?[indexValue!]['cType']
                  .toString(),
              'value': caseDetailsAPIValue.addressDetails?[indexValue!]['value']
                  .toString(),
              'health': ConstantEventValues.addressCustomerNotMetHealth,
              // 'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
            },
            addressSelectedCustomerNotMetClip,
            event.context,
            emit);
      }
    }
  }

  void customerNotMetButtonClick(
    String eventType,
    String caseId,
    String eventName,
    String followUpPriority,
    dynamic contact,
    String selectedClipValue,
    BuildContext context,
    Emitter<CaseDetailsState> emit,
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
        headingAccuracy: 0,
        altitudeAccuracy: 0);
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

    final Position res = await geolocatorPlatform.getCurrentPosition();

    position = res;
    final CustomerNotMetPostModel requestBodyData = CustomerNotMetPostModel(
        eventId: ConstantEventValues.addressCustomerNotMetEventId,
        eventType: eventType,
        caseId: caseId,
        eventCode: ConstantEventValues.addressCustomerNotMetEvenCode,
        contact: contact,
        eventModule: 'Field Allocation',
        callerServiceID: Singleton.instance.callerServiceID,
        callID: Singleton.instance.callID,
        callingID: Singleton.instance.callingID,
        voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
        // createdAt: (ConnectivityResult.none ==
        //         await Connectivity().checkConnectivity())
        //     ? DateTime.now().toString()
        //     : null,
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        contractor: Singleton.instance.contractor ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        invalidNumber: Singleton.instance.invalidNumber,
        eventAttr: CustomerNotMetEventAttr(
          remarks: addressCustomerNotMetRemarksController.text.isNotEmpty
              ? addressCustomerNotMetRemarksController.text
              : null,
          followUpPriority: followUpPriority,
          nextActionDate: addressCustomerNotMetSelectedDate != ''
              ? addressCustomerNotMetSelectedDate
              : addressCustomerNotMetNextActionDateController.text,
          longitude: position.longitude,
          latitude: position.latitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          heading: position.heading,
          speed: position.speed,
          reginalText: returnS2TCustomerNotMet.result?.reginalText,
          translatedText: returnS2TCustomerNotMet.result?.translatedText,
          audioS3Path: returnS2TCustomerNotMet.result?.audioS3Path,
        ));
    Map<String, dynamic> postResult = <String, dynamic>{'success': false};

    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      await FirebaseUtils.storeEvents(
              eventsDetails: requestBodyData.toJson(),
              caseId: caseId,
              selectedFollowUpDate: addressCustomerNotMetSelectedDate != ''
                  ? addressCustomerNotMetSelectedDate
                  : addressCustomerNotMetNextActionDateController.text,
              selectedClipValue: ConvertString.convertLanguageToConstant(
                  selectedClipValue, context),
              bloc: this)
          .then((bool value) {
        //For navigation purpose - back screen
        postResult = <String, dynamic>{'success': true};
      });
    } else {
      final CaseRepositoryImpl caseRepositoryImpl = CaseRepositoryImpl();
      final ApiResult<BaseResponse> eventResult = await caseRepositoryImpl
          .postCaseEvent(jsonEncode(requestBodyData), eventName);
      await eventResult.when(success: (BaseResponse? result) async {
        await FirebaseUtils.storeEvents(
                eventsDetails: requestBodyData.toJson(),
                caseId: caseId,
                selectedFollowUpDate: addressCustomerNotMetSelectedDate != ''
                    ? addressCustomerNotMetSelectedDate
                    : addressCustomerNotMetNextActionDateController.text,
                selectedClipValue: ConvertString.convertLanguageToConstant(
                    selectedClipValue, context),
                bloc: this)
            .then((bool value) {});
        submitedEventType = 'Customer Not Met';
        isSubmitedForMyVisits = true;
        isEventSubmited = true;
        caseDetailsAPIValue.caseDetails?.collSubStatus =
            ConvertString.convertLanguageToConstant(selectedClipValue, context);
        addressCustomerNotMetSelectedDate = '';
        addressCustomerNotMetNextActionDateController.text = '';
        addressCustomerNotMetRemarksController.clear();
        addressSelectedCustomerNotMetClip = '';
        returnS2TCustomerNotMet.result?.reginalText = null;
        returnS2TCustomerNotMet.result?.translatedText = null;
        returnS2TCustomerNotMet.result?.audioS3Path = null;
        emit(UpdateHealthStatusState());
        emit(PostDataApiSuccessState());
        emit(EnableCustomerNotMetBtnState());
      }, failure: (NetworkExceptions? error) async {
        emit(EnableCustomerNotMetBtnState());
      });
    }
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
