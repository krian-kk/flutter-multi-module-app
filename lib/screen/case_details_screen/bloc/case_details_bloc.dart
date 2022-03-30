import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/address_invalid_post_model/address_invalid_post_model.dart';
import 'package:origa/models/case_details_api_model/case_details.dart';
import 'package:origa/models/case_details_api_model/case_details_api_model.dart';
import 'package:origa/models/case_details_api_model/result.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/models/customer_not_met_post_model/customer_not_met_post_model.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/models/imagecaptured_post_model.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/models/phone_invalid_post_model/phone_invalid_post_model.dart';
import 'package:origa/models/phone_unreachable_post_model/phone_unreachable_post_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/send_sms_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/call_customer_screen/call_customer_bottom_sheet.dart';
import 'package:origa/screen/collection_screen/collections_bottom_sheet.dart';
import 'package:origa/screen/dispute_screen/dispute_bottom_sheet.dart';
import 'package:origa/screen/event_details_screen/event_details_bottom_sheet.dart';
import 'package:origa/screen/other_feed_back_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/ots_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/ptp_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/remainder_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/rtp_screen/rtp_bottom_sheet.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/call_status_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/language_to_constant_convert.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/generate_payment_link_model.dart';
import '../../../models/get_payment_configuration_model.dart';

part 'case_details_event.dart';

part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  AllocationBloc allocationBloc;

  //Offline purpose
  dynamic selectedAddressModel;

  CaseDetailsBloc(this.allocationBloc) : super(CaseDetailsInitial());
  String? caseId;
  String? custName;
  String? agentName;
  bool isEventSubmited = false;
  bool isSubmitedForMyVisits = false;
  String submitedEventType = '';
  dynamic collectionAmount;
  bool isAutoCalling = false;
  String? changeFollowUpDate;

  BuildContext? caseDetailsContext;

  int? indexValue;
  String? userType;
  dynamic paramValue;

  // Online Purpose
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';
  CaseDetailsApiModel caseDetailsAPIValue = CaseDetailsApiModel();

  // Address Details Screen
  String addressSelectedCustomerNotMetClip = '';
  String addressSelectedInvalidClip = '';

  final addressCustomerNotMetFormKey = GlobalKey<FormState>();
  final addressInvalidFormKey = GlobalKey<FormState>();

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

  List<CustomerMetGridModel> addressCustomerMetGridList = [];
  List<OtherFeedbackExpandModel> expandOtherFeedback = [];
  List<EventExpandModel> expandEvent = [];

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
  List<CustomerMetGridModel> phoneCustomerMetGridList = [];

  final phoneUnreachableFormKey = GlobalKey<FormState>();
  final phoneInvalidFormKey = GlobalKey<FormState>();

  TextEditingController phoneUnreachableNextActionDateController =
      TextEditingController();
  String phoneUnreachableSelectedDate = '';
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

//store list off Address
  List<dynamic>? listOfAddressDetails = [];

//store list off Mobile no
  List<dynamic>? listOfCallDetails = [];
  List<Address>? listOfAddress;

// Repayment info send sms loading
  bool isSendSMSloading = false;

// its used to show QR button in Customer met screen
  bool isShowQRcode = false;
  bool isQRcodeBtnLoading = false;

// its used to GeneratePaymentLink button in Case detail screen
  bool isGeneratePaymentLink = false;
  bool isGeneratePaymentLinkLoading = false;

  @override
  Stream<CaseDetailsState> mapEventToState(CaseDetailsEvent event) async* {
    if (event is CaseDetailsInitialEvent) {
      yield CaseDetailsLoadingState();
      caseDetailsContext = event.context;
      Singleton.instance.buildContext = event.context;
      caseId = event.paramValues['caseID'];
      paramValue = event.paramValues;
      listOfAddress = event.paramValues['mobileList'];
      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString(Constants.userType);
      agentName = _pref.getString(Constants.agentName);
      // check internet
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        await FirebaseFirestore.instance
            .collection(Singleton.instance.firebaseDatabaseName)
            .doc(Singleton.instance.agentRef)
            .collection(Constants.firebaseCase)
            .doc('${event.paramValues['caseID']}')
            .get(const GetOptions(source: Source.cache))
            .then((value) {
          Map<String, dynamic>? jsonData = value.data();
          CaseDetails caseDetails = CaseDetails.fromJson(jsonData!);
          caseDetailsAPIValue.result =
              CaseDetailsResultModel.fromJson(jsonData);
          caseDetailsAPIValue.result?.caseDetails = caseDetails;
          caseDetailsAPIValue.result?.callDetails = caseDetailsAPIValue
              .result?.callDetails
              ?.where((element) => (element['cType'] == 'mobile'))
              .toList();
          caseDetailsAPIValue.result?.callDetails?.sort(
              (a, b) => (b['health'] ?? '1.5').compareTo(a['health'] ?? '1.5'));
          Singleton.instance.caseCustomerName =
              caseDetailsAPIValue.result?.caseDetails?.cust ?? '';
        });
      } else {
        isNoInternetAndServerError = false;
        Map<String, dynamic> caseDetailsData = await APIRepository.apiRequest(
            APIRequestType.get, HttpUrl.caseDetailsUrl + 'caseId=$caseId',
            isPop: true);
        if (caseDetailsData[Constants.success] == true) {
          Map<String, dynamic> jsonData = caseDetailsData['data'];
          caseDetailsAPIValue = CaseDetailsApiModel.fromJson(jsonData);
          caseDetailsAPIValue.result?.callDetails = caseDetailsAPIValue
              .result?.callDetails
              ?.where((element) => (element['cType'] == 'mobile'))
              .toList();
          caseDetailsAPIValue.result?.callDetails?.sort(
              (a, b) => (b['health'] ?? '1.5').compareTo(a['health'] ?? '1.5'));
          Singleton.instance.caseCustomerName =
              caseDetailsAPIValue.result?.caseDetails?.cust ?? '';
        } else if (caseDetailsData['statusCode'] == 401 ||
            caseDetailsData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          noInternetAndServerErrorMsg = caseDetailsData['data'];
        }
      }

      Singleton.instance.overDueAmount =
          caseDetailsAPIValue.result?.caseDetails!.odVal.toString() ?? '';
      Singleton.instance.agrRef =
          caseDetailsAPIValue.result?.caseDetails?.agrRef ?? '';

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
      emiStartDateController.text =
          (caseDetailsAPIValue.result?.caseDetails!.emiStartDate.toString() ==
                  null)
              ? '-'
              : ((caseDetailsAPIValue
                              .result?.caseDetails!.emiStartDate
                              .toString()
                              .length ??
                          0) >
                      11)
                  ? DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(caseDetailsAPIValue
                              .result?.caseDetails!.emiStartDate
                              .toString() ??
                          ''))
                      .toString()
                      .toUpperCase()
                  : caseDetailsAPIValue.result?.caseDetails!.emiStartDate
                          .toString()
                          .replaceAll('-', '/')
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

      // Clear the lists
      listOfAddressDetails?.clear();
      listOfCallDetails?.clear();
      //Stor list of address
      listOfAddressDetails = caseDetailsAPIValue.result?.addressDetails!;
      //Stor list of contacts (mobile Numbers)
      listOfCallDetails = caseDetailsAPIValue.result?.callDetails!;

      addressCustomerMetGridList.addAll([
        CustomerMetGridModel(
            ImageResource.ptp, Languages.of(event.context!)!.ptp.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.ptp,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(
            ImageResource.rtp, Languages.of(event.context!)!.rtp.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.rtp,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.dispute,
            Languages.of(event.context!)!.dispute.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.dispute,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(
            ImageResource.remainder,
            (Languages.of(event.context!)!.remainderCb.toUpperCase())
                .toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.remainder,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(ImageResource.collections,
            Languages.of(event.context!)!.collections.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.collections,
                caseDetailsAPIValue.result?.addressDetails!, false))),
        CustomerMetGridModel(
            ImageResource.ots, Languages.of(event.context!)!.ots.toUpperCase(),
            onTap: () => add(EventDetailsEvent(Constants.ots,
                caseDetailsAPIValue.result?.addressDetails!, false))),
      ]);

      // Customer Not met Next Action Date is = Current Date + 3 days
      addressCustomerNotMetNextActionDateController.text =
          DateFormat('yyyy-MM-dd')
              .format(DateTime.now().add(const Duration(days: 3)));
      // Unreachable Next Action Date is = Current Date + 1 days
      phoneUnreachableNextActionDateController.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(const Duration(days: 1)));

      // Check Payment Configuartion Details and store the value of dynamicLink [isGeneratePaymentLink] and qrCode [isShowQRcode]
      if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
        PaymentConfigurationModel paymentCofigurationData =
            PaymentConfigurationModel();
        Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.get,
          HttpUrl.getPaymentConfiguration,
        );
        if (postResult[Constants.success]) {
          paymentCofigurationData =
              PaymentConfigurationModel.fromJson(postResult['data']);

          isShowQRcode = paymentCofigurationData.data![0].payment![0].qrCode!;
          isGeneratePaymentLink =
              paymentCofigurationData.data![0].payment![0].dynamicLink!;
        }
      }
      yield CaseDetailsLoadedState();
      if (event.paramValues['isAutoCalling'] != null) {
        isAutoCalling = true;
        indexValue = allocationBloc.indexValue;
        // yield ClickMainCallBottomSheetState(0);
        yield PhoneBottomSheetSuccessState();
      }
    }
    if (event is PhoneBottomSheetInitialEvent) {
      yield PhoneBottomSheetLoadingState();
      phoneCustomerMetGridList.clear();
      phoneCustomerMetGridList.addAll([
        CustomerMetGridModel(
            ImageResource.ptp, Languages.of(event.context)!.ptp.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                  Constants.ptp,
                  caseDetailsAPIValue.result?.callDetails!,
                  true,
                  isCallFromCallDetails: event.isCallFromCaseDetails,
                  callId: event.callId,
                )),
            isCall: true),
        CustomerMetGridModel(
            ImageResource.rtp, Languages.of(event.context)!.rtp.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                  Constants.rtp,
                  caseDetailsAPIValue.result?.callDetails!,
                  true,
                  isCallFromCallDetails: event.isCallFromCaseDetails,
                  callId: event.callId,
                )),
            isCall: true),
        CustomerMetGridModel(ImageResource.dispute,
            Languages.of(event.context)!.dispute.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                  Constants.dispute,
                  caseDetailsAPIValue.result?.callDetails!,
                  true,
                  isCallFromCallDetails: event.isCallFromCaseDetails,
                  callId: event.callId,
                )),
            isCall: true),
        CustomerMetGridModel(
            ImageResource.remainder,
            (Languages.of(event.context)!.remainderCb.toUpperCase())
                .toUpperCase()
                .toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                  Constants.remainder,
                  caseDetailsAPIValue.result?.callDetails!,
                  true,
                  isCallFromCallDetails: event.isCallFromCaseDetails,
                  callId: event.callId,
                )),
            isCall: true),
        CustomerMetGridModel(ImageResource.collections,
            Languages.of(event.context)!.collections.toUpperCase(),
            onTap: () => add(EventDetailsEvent(
                  Constants.collections,
                  caseDetailsAPIValue.result?.callDetails!,
                  true,
                  isCallFromCallDetails: event.isCallFromCaseDetails,
                  callId: event.callId,
                )),
            isCall: true),
        CustomerMetGridModel(ImageResource.ots, Constants.ots,
            onTap: () => add(EventDetailsEvent(
                  Languages.of(event.context)!.ots.toUpperCase(),
                  caseDetailsAPIValue.result?.callDetails!,
                  true,
                  isCallFromCallDetails: event.isCallFromCaseDetails,
                  callId: event.callId,
                )),
            isCall: true),
      ]);
      yield PhoneBottomSheetLoadedState();
    }
    if (event is AddedNewAddressListEvent) {
      yield AddedNewAddressListState();
    }
    if (event is AddedNewCallContactListEvent) {
      yield AddedNewCallContactListState();
    }
    if (event is ClickMainAddressBottomSheetEvent) {
      indexValue = event.index;
      yield ClickMainAddressBottomSheetState(event.index,
          addressModel: event.addressModel);
    }
    if (event is ClickMainCallBottomSheetEvent) {
      indexValue = event.index;
      yield ClickMainCallBottomSheetState(
        event.index,
        isCallFromCaseDetails: event.isCallFromCaseDetails,
        callId: event.callId,
      );
    }
    if (event is ClickViewMapEvent) {
      yield ClickViewMapState();
    }
    if (event is ClickCaseDetailsEvent) {
      yield CallCaseDetailsState(paramValues: event.paramValues);
    }
    if (event is ClickPushAndPOPCaseDetailsEvent) {
      yield PushAndPOPNavigationCaseDetailsState(
          paramValues: event.paramValues);
    }
    if (event is ChangeIsSubmitEvent) {
      if (Singleton.instance.usertype == Constants.telecaller) {
        caseDetailsAPIValue.result?.caseDetails?.telSubStatus =
            event.selectedClipValue;
      } else {
        caseDetailsAPIValue.result?.caseDetails?.collSubStatus =
            event.selectedClipValue;
      }
      isEventSubmited = true;
      yield UpdateSuccessfullState();
    }
    if (event is ChangeIsSubmitForMyVisitEvent) {
      // null -> ptp
      submitedEventType = event.eventType;
      isSubmitedForMyVisits = true;
      if (event.eventType == Constants.collections) {
        collectionAmount = event.collectionAmount;
      }
      yield UpdateSuccessfullState();
    }
    if (event is EventDetailsEvent) {
      yield CaseDetailsLoadingState();
      if (isAutoCalling || paramValue['contactIndex'] != null) {
        openBottomSheet(
            caseDetailsContext!, event.title, event.list ?? [], event.isCall);
      } else {
        yield ClickOpenBottomSheetState(
          event.title,
          event.list!,
          event.isCall,
          health: event.health,
          selectedContactNumber: event.seleectedContactNumber,
          isCallFromCallDetails: event.isCallFromCallDetails,
          callId: event.callId,
        );
      }
    }
    if (event is ChangeFollowUpDateEvent) {
      changeFollowUpDate = event.followUpDate;
    }
    if (event is PostImageCapturedEvent) {
      yield DisableCaptureImageBtnState();
      final Map<String, dynamic> postdata =
          jsonDecode(jsonEncode(event.postData!.toJson()))
              as Map<String, dynamic>;
      List<dynamic> value = [];
      for (var element in event.fileData!) {
        value.add(await MultipartFile.fromFile(element.path.toString()));
      }
      postdata.addAll({
        'files': value,
      });
      //do do do do
      Map<String, dynamic> firebaseObject = event.postData!.toJson();
      try {
        firebaseObject
            .addAll(FirebaseUtils.toPrepareFileStoringModel(event.fileData!));
      } catch (e) {
        debugPrint('Exception while converting base64 ${e.toString()}');
      }
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        await FirebaseUtils.storeEvents(
            eventsDetails: firebaseObject, caseId: caseId, bloc: this);
        yield PostDataApiSuccessState();
      } else {
        // For local storage purpose storing while online
        await FirebaseUtils.storeEvents(
            eventsDetails: firebaseObject, caseId: caseId, bloc: this);
        Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.upload,
          HttpUrl.imageCaptured + "userType=$userType",
          formDatas: FormData.fromMap(postdata),
        );
        if (postResult[Constants.success]) {
          yield PostDataApiSuccessState();
        }
      }
      yield EnableCaptureImageBtnState();
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
          addressSelectedCustomerNotMetClip,
          event.context,
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
              'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
            }
          ],
          addressSelectedCustomerNotMetClip,
          event.context,
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
              'resAddressId_0': Singleton.instance.resAddressId_0 ?? '',
            }
          ],
          addressSelectedCustomerNotMetClip,
          event.context,
        );
      }
      if (resultValue[Constants.success]) {
        yield UpdateHealthStatusState();
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
              HttpUrl.wrongAddressUrl(
                'invalidAddress',
                userType.toString(),
              ),
              agentName.toString(),
              agentName.toString(),
              agentName.toString(),
              'PTP',
              addressSelectedInvalidClip,
              event.context,
            );
          } else if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.shifted) {
            resultValue = await addressInvalidButtonClick(
              Constants.shifted,
              caseId.toString(),
              HttpUrl.shiftedUrl('shifted', userType.toString()),
              agentName.toString(),
              agentName.toString(),
              agentName.toString(),
              'REVIEW',
              addressSelectedInvalidClip,
              event.context,
            );
          } else if (addressSelectedInvalidClip ==
              Languages.of(event.context)!.addressNotFound) {
            resultValue = await addressInvalidButtonClick(
              Constants.addressNotFound,
              caseId.toString(),
              HttpUrl.addressNotFoundUrl(
                'addressNotFound',
                userType.toString(),
              ),
              agentName.toString(),
              agentName.toString(),
              agentName.toString(),
              'PTP',
              addressSelectedInvalidClip,
              event.context,
            );
          }
        } else {
          AppUtils.showToast(Languages.of(event.context)!.pleaseSelectOptions);
        }
      }
      if (resultValue[Constants.success]) {
        yield UpdateHealthStatusState();
        yield PostDataApiSuccessState();
      }
      yield EnableAddressInvalidBtnState();
    }
    if (event is ClickPhoneInvalidButtonEvent) {
      yield DisablePhoneInvalidBtnState();
      bool isNotAutoCalling = true;
      if (isAutoCalling ||
          (event.isCallFromCaseDetails && event.callId != null)) {
        await CallCustomerStatus.callStatusCheck(
                callId: (event.isCallFromCaseDetails)
                    ? event.callId
                    : paramValue['callId'],
                context: event.context)
            .then((value) {
          isNotAutoCalling = value;
        });
      }
      if (isNotAutoCalling) {
        late Map<String, dynamic> resultValue = {Constants.success: false};
        if (phoneInvalidFormKey.currentState!.validate()) {
          if (phoneSelectedInvalidClip != '') {
            if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.doesNotExist) {
              resultValue = await phoneInvalidButtonClick(
                Constants.doesNotExist,
                caseId.toString(),
                HttpUrl.numberNotWorkingUrl(
                  'doesNotExist',
                  userType.toString(),
                ),
                phoneSelectedInvalidClip,
                event.context,
              );
            } else if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.incorrectNumber) {
              resultValue = await phoneInvalidButtonClick(
                Constants.incorrectNumber,
                caseId.toString(),
                HttpUrl.incorrectNumberUrl(
                  'incorrectNo',
                  userType.toString(),
                ),
                phoneSelectedInvalidClip,
                event.context,
              );
            } else if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.numberNotWorking) {
              resultValue = await phoneInvalidButtonClick(
                Constants.numberNotWorking,
                caseId.toString(),
                HttpUrl.numberNotWorkingUrl(
                  'numberNotWorking',
                  userType.toString(),
                ),
                phoneSelectedInvalidClip,
                event.context,
              );
            } else if (phoneSelectedInvalidClip ==
                Languages.of(event.context)!.notOperational) {
              resultValue = await phoneInvalidButtonClick(
                Constants.notOpeartional,
                caseId.toString(),
                HttpUrl.notOperationalUrl(
                  'notOperational',
                  userType.toString(),
                ),
                phoneSelectedInvalidClip,
                event.context,
              );
            }
          } else {
            AppUtils.showToast(
              Languages.of(event.context)!.pleaseSelectOptions,
            );
          }
        }
        if (resultValue[Constants.success]) {
          if (isAutoCalling) {
            if (event.autoCallingStopAndSubmit) {
              allocationBloc.add(StartCallingEvent(
                customerIndex: paramValue['customerIndex'],
                phoneIndex: paramValue['phoneIndex'] + 1,
              ));
            }
            Singleton.instance.startCalling = false;
            Navigator.pop(paramValue['context']);
          }
          yield UpdateHealthStatusState();

          // update autocalling screen case list of contact health
          if (paramValue['contactIndex'] != null ||
              paramValue['phoneIndex'] != null) {
            allocationBloc.add(AutoCallContactHealthUpdateEvent(
              contactIndex: paramValue['contactIndex'],
              caseIndex: paramValue['caseIndex'],
            ));
          }
        }

        yield PostDataApiSuccessState();
      }
      yield EnablePhoneInvalidBtnState();
    }
    if (event is ClickPhoneUnreachableSubmitedButtonEvent) {
      yield DisableUnreachableBtnState();
      bool isNotAutoCalling = true;
      if (isAutoCalling ||
          (event.isCallFromCaseDetails && event.callId != null)) {
        await CallCustomerStatus.callStatusCheck(
                callId: (event.isCallFromCaseDetails)
                    ? event.callId
                    : paramValue['callId'],
                context: event.context)
            .then((value) {
          isNotAutoCalling = value;
        });
      }
      if (isNotAutoCalling) {
        late Map<String, dynamic> resultValue;
        if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.lineBusy) {
          resultValue = await unreachableButtonClick(
            Constants.lineBusy,
            caseId.toString(),
            ConstantEventValues.lineBusyEvenCode,
            HttpUrl.unreachableUrl(
              'lineBusy',
              userType.toString(),
            ),
            phoneSelectedUnreadableClip,
            event.context,
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.switchOff) {
          resultValue = await unreachableButtonClick(
            Constants.switchOff,
            caseId.toString(),
            ConstantEventValues.switchOffEvenCode,
            HttpUrl.unreachableUrl(
              'switchOff',
              userType.toString(),
            ),
            phoneSelectedUnreadableClip,
            event.context,
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.rnr) {
          resultValue = await unreachableButtonClick(
            Constants.rnr,
            caseId.toString(),
            ConstantEventValues.rnrEvenCode,
            HttpUrl.unreachableUrl(
              'RNR',
              userType.toString(),
            ),
            phoneSelectedUnreadableClip,
            event.context,
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.outOfNetwork) {
          resultValue = await unreachableButtonClick(
            Constants.outOfNetwork,
            caseId.toString(),
            ConstantEventValues.outOfNetworkEvenCode,
            HttpUrl.unreachableUrl(
              'outOfNetwork',
              userType.toString(),
            ),
            phoneSelectedUnreadableClip,
            event.context,
          );
        } else if (phoneSelectedUnreadableClip ==
            Languages.of(event.context)!.disConnecting) {
          resultValue = await unreachableButtonClick(
            Constants.disconnecting,
            caseId.toString(),
            ConstantEventValues.disConnectingEvenCode,
            HttpUrl.unreachableUrl(
              'disconnecting',
              userType.toString(),
            ),
            phoneSelectedUnreadableClip,
            event.context,
          );
        }
        if (resultValue[Constants.success]) {
          isSubmitedForMyVisits = true;
          submitedEventType = 'Phone Unreachable';
          if (userType == Constants.telecaller) {
            isEventSubmited = true;
          }
          if (isAutoCalling) {
            if (event.autoCallingStopAndSubmit) {
              allocationBloc.add(StartCallingEvent(
                customerIndex: paramValue['customerIndex'],
                phoneIndex: paramValue['phoneIndex'] + 1,
              ));
            }
            Singleton.instance.startCalling = false;
            Navigator.pop(paramValue['context']);
          }
          yield UpdateHealthStatusState();

          // update autocalling screen case list of contact health
          if (paramValue['contactIndex'] != null ||
              paramValue['phoneIndex'] != null) {
            allocationBloc.add(AutoCallContactHealthUpdateEvent(
              contactIndex: paramValue['contactIndex'],
              caseIndex: paramValue['caseIndex'],
            ));
          }
          yield PostDataApiSuccessState();
        }
      }
      yield EnableUnreachableBtnState();
    }
    if (event is SendSMSEvent) {
      yield SendSMSloadState();
      if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
        if (Singleton.instance.contractorInformations!.result!.sendSms!) {
          var requestBodyData = SendSMS(
            agentRef: Singleton.instance.agentRef,
            agrRef: Singleton.instance.agrRef,
            type: event.type,
          );
          Map<String, dynamic> postResult = await APIRepository.apiRequest(
            APIRequestType.post,
            HttpUrl.sendSMSurl,
            requestBodydata: jsonEncode(requestBodyData),
          );
          if (postResult[Constants.success]) {
            AppUtils.topSnackBar(event.context, Constants.successfullySMSsend);
          }
        } else {
          AppUtils.showErrorToast(Languages.of(event.context)!.sendSMSerror);
        }
      } else {
        AppUtils.showErrorToast(
            Languages.of(event.context)!.noInternetConnection);
      }
      yield SendSMSloadState();
    }

    // if (event is GetPaymentConfigurationEvent) {
    //   PaymentConfigurationModel paymentCofigurationData =
    //       PaymentConfigurationModel();
    //   Map<String, dynamic> postResult = await APIRepository.apiRequest(
    //     APIRequestType.get,
    //     HttpUrl.getPaymentConfiguration,
    //   );
    //   if (postResult[Constants.success]) {
    //     paymentCofigurationData =
    //         PaymentConfigurationModel.fromJson(postResult['data']);
    //     isShowQRcode = paymentCofigurationData.data![0].payment![0].qrCode!;
    //     isGeneratePaymentLink =
    //         paymentCofigurationData.data![0].payment![0].dynamicLink!;
    //   }
    // }

    if (event is GeneratePaymenLinktEvent) {
      isGeneratePaymentLinkLoading = true;

      GeneratePaymentLinkModel generatePaymentLink = GeneratePaymentLinkModel();
      var requestBodyData = GeneratePaymentLinkPost(
        caseId: event.caseID,
        dynamicLink: true,
      );
      // if dynamic_link is true means creating a Ref URL and false means creating QR code
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.post,
        HttpUrl.generateDyanamicPaymentLink,
        requestBodydata: jsonEncode(requestBodyData),
      );
      if (postResult[Constants.success]) {
        generatePaymentLink =
            GeneratePaymentLinkModel.fromJson(postResult['data']);

        yield UpdateRefUrlState(
            refUrl: generatePaymentLink.data!.data!.paymentLink);
      } else {
        AppUtils.showToast('Error while generating Payment Link');
      }
    }
    if (event is GenerateQRcodeEvent) {
      GeneratePaymentLinkModel generatePaymentLink = GeneratePaymentLinkModel();
      var requestBodyData = GeneratePaymentLinkPost(
        caseId: event.caseID,
        dynamicLink: false,
      );
      // if dynamic_link is true means creating a Ref URL and false means creating QR code
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.post,
        HttpUrl.generateDyanamicPaymentLink,
        requestBodydata: jsonEncode(requestBodyData),
      );
      if (postResult[Constants.success]) {
        generatePaymentLink =
            GeneratePaymentLinkModel.fromJson(postResult['data']);
        yield GenerateQRcodeState(
            qrUrl: generatePaymentLink.data!.data!.qrLink);
      } else {
        AppUtils.showToast('Error while generating QR coxde');
      }
    }
    if (event is UpdateHealthStatusEvent) {
      Singleton.instance.updateHealthStatus = {
        'selectedHealthIndex': event.selectedHealthIndex!,
        'tabIndex': event.tabIndex,
        'currentHealth': event.currentHealth,
      };
    }
    if (event is ChangeHealthStatusEvent) {
      // update autocalling screen case list of contact health
      if (paramValue['contactIndex'] != null ||
          paramValue['phoneIndex'] != null) {
        allocationBloc.add(AutoCallContactHealthUpdateEvent(
          contactIndex: paramValue['contactIndex'],
          caseIndex: paramValue['caseIndex'],
        ));
      }

      yield UpdateHealthStatusState();
    }
  }

  // Open the Bottom Sheet Only in Auto Calling Feature
  openBottomSheet(
      BuildContext buildContext, String cardTitle, List list, bool? isCall,
      {String? health}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        switch (cardTitle) {
          case Constants.ptp:
            return CustomPtpBottomSheet(
              Languages.of(context)!.ptp,
              caseId: caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              userType: userType.toString(),
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              isCall: isCall,
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
              bloc: this,
            );
          case Constants.rtp:
            return CustomRtpBottomSheet(
              Languages.of(context)!.rtp,
              caseId: caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              userType: userType.toString(),
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              isCall: isCall,
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
              bloc: this,
            );
          case Constants.dispute:
            return CustomDisputeBottomSheet(
              Languages.of(context)!.dispute,
              caseId: caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              userType: userType.toString(),
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              isCall: isCall,
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
              bloc: this,
            );
          case Constants.remainder:
            return CustomRemainderBottomSheet(
              Languages.of(context)!.remainderCb,
              caseId: caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              userType: userType.toString(),
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              isCall: isCall,
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
              bloc: this,
            );
          case Constants.collections:
            return CustomCollectionsBottomSheet(
              Languages.of(context)!.collections,
              caseId: caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              isCall: isCall,
              userType: userType.toString(),
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              custName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
              bloc: this,
            );
          case Constants.ots:
            return CustomOtsBottomSheet(
              Languages.of(context)!.ots,
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              caseId: caseId.toString(),
              userType: userType.toString(),
              isCall: isCall,
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
              bloc: this,
            );

          case Constants.otherFeedback:
            return CustomOtherFeedBackBottomSheet(
              Languages.of(context)!.otherFeedBack,
              this,
              caseId: caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              userType: userType.toString(),
              postValue: indexValue != null
                  ? list[indexValue!]
                  : list[paramValue['contactIndex']],
              isCall: isCall,
              health: health ?? ConstantEventValues.healthTwo,
              isAutoCalling: isAutoCalling,
              allocationBloc: allocationBloc,
              paramValue: paramValue,
            );
          case Constants.eventDetails:
            return CustomEventDetailsBottomSheet(
              Languages.of(context)!.eventDetails,
              this,
              customeLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
            );

          case Constants.callCustomer:
            List<String> s1 = [];
            caseDetailsAPIValue.result?.callDetails?.forEach((element) {
              if (element['cType'].contains('mobile')) {
                if (!(s1.contains(element['value']))) {
                  s1.add(element['value']);
                }
              } else {}
            });
            return CallCustomerBottomSheet(
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${caseDetailsAPIValue.result?.caseDetails?.bankName} / ${caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                        0.0,
              ),
              listOfMobileNo: s1,
              userType: userType.toString(),
              caseId: caseId.toString(),
              custName: caseDetailsAPIValue.result?.caseDetails?.cust ?? "",
              sid: caseDetailsAPIValue.result!.caseDetails!.id.toString(),
              contactNumber: listOfAddress![paramValue['phoneIndex']].value,
              caseDetailsBloc: this,
              caseDetailsAPIValue: caseDetailsAPIValue,
            );

          default:
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    BottomSheetAppbar(
                        title: '', padding: EdgeInsets.fromLTRB(23, 16, 15, 5)),
                    Expanded(child: CustomLoadingWidget()),
                  ],
                ));
        }
      },
    );
  }

  Future<Map<String, dynamic>> unreachableButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
    String selectedClipValue,
    BuildContext context,
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
          reginalText: returnS2TUnReachable.result?.reginalText,
          translatedText: returnS2TUnReachable.result?.translatedText,
          audioS3Path: returnS2TUnReachable.result?.audioS3Path,
        ),
        eventModule: 'Telecalling',
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        contractor: Singleton.instance.contractor ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        contact: PhoneUnreachbleContact(
          cType: indexValue != null
              ? caseDetailsAPIValue.result?.callDetails![indexValue!]['cType']
              : caseDetailsAPIValue
                  .result?.callDetails![paramValue['contactIndex']]['cType'],
          value: indexValue != null
              ? caseDetailsAPIValue.result?.callDetails![indexValue!]['value']
              : caseDetailsAPIValue
                  .result?.callDetails![paramValue['contactIndex']]['value'],
          health: ConstantEventValues.phoneUnreachableHealth,
          contactId0: Singleton.instance.contactId_0 ?? '',
        ));

    Map<String, dynamic> postResult = {'success': false};
    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      await FirebaseUtils.storeEvents(
              eventsDetails: requestBodyData.toJson(),
              caseId: caseId,
              selectedClipValue: ConvertString.convertLanguageToConstant(
                  selectedClipValue, context),
              bloc: this)
          .then((value) {
        postResult = {'success': true};
      });
    } else {
      // For local storage purpose storing while online
      await FirebaseUtils.storeEvents(
          eventsDetails: requestBodyData.toJson(),
          caseId: caseId,
          selectedClipValue: ConvertString.convertLanguageToConstant(
              selectedClipValue, context),
          bloc: this);
      postResult = await APIRepository.apiRequest(
        APIRequestType.post,
        urlString,
        requestBodydata: jsonEncode(requestBodyData),
      );
    }

    if (await postResult[Constants.success]) {
      isSubmitedForMyVisits = true;
      submitedEventType = 'Unreachable';
      if (userType == Constants.telecaller) {
        isEventSubmited = true;
      }
      if (Singleton.instance.usertype == Constants.telecaller) {
        caseDetailsAPIValue.result?.caseDetails?.telSubStatus =
            ConvertString.convertLanguageToConstant(selectedClipValue, context);
      } else {
        caseDetailsAPIValue.result?.caseDetails?.collSubStatus =
            selectedClipValue;
      }
      phoneUnreachableSelectedDate = '';
      phoneUnreachableNextActionDateController.text = '';
      phoneUnreachableRemarksController.text = '';
      phoneSelectedUnreadableClip = '';
    }
    return postResult;
  }

  Future<Map<String, dynamic>> customerNotMetButtonClick(
    String eventType,
    String caseId,
    String urlString,
    String followUpPriority,
    dynamic contact,
    String selectedClipValue,
    BuildContext context,
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
        contractor: Singleton.instance.contractor ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        eventAttr: CustomerNotMetEventAttr(
          remarks: addressCustomerNotMetRemarksController.text,
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
    Map<String, dynamic> postResult = {'success': false};

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
          .then((value) {
        //For navigation purpose - back screen
        postResult = {'success': true};
      });
    } else {
      await FirebaseUtils.storeEvents(
          eventsDetails: requestBodyData.toJson(),
          caseId: caseId,
          selectedFollowUpDate: addressCustomerNotMetSelectedDate != ''
              ? addressCustomerNotMetSelectedDate
              : addressCustomerNotMetNextActionDateController.text,
          selectedClipValue: ConvertString.convertLanguageToConstant(
              selectedClipValue, context),
          bloc: this);
      postResult = await APIRepository.apiRequest(
        APIRequestType.post,
        urlString,
        requestBodydata: jsonEncode(requestBodyData),
      );
    }
    if (await postResult[Constants.success]) {
      submitedEventType = 'Customer Not Met';
      isSubmitedForMyVisits = true;
      isEventSubmited = true;
      caseDetailsAPIValue.result?.caseDetails?.collSubStatus =
          ConvertString.convertLanguageToConstant(selectedClipValue, context);
      addressCustomerNotMetSelectedDate = '';
      addressCustomerNotMetNextActionDateController.text = '';
      addressCustomerNotMetRemarksController.text = '';
      addressSelectedCustomerNotMetClip = '';
    } else {}
    return postResult;
  }

  //user via from address details -> only for collector
  Future<Map<String, dynamic>> addressInvalidButtonClick(
    String eventType,
    String caseId,
    String urlString,
    String createdBy,
    String agentName,
    String agrRef,
    String followUpPriority,
    String selectedClipValue,
    BuildContext context,
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
        contractor: Singleton.instance.contractor ?? '',
        agrRef: Singleton.instance.agrRef ?? '',
        eventType: eventType,
        caseId: caseId,
        eventCode: ConstantEventValues.addressInvalidEvenCode,
        eventAttr: AddressInvalidEventAttr(
          remarks: addressInvalidRemarksController.text,
          followUpPriority: followUpPriority,
          longitude: position.longitude,
          latitude: position.latitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          heading: position.heading,
          speed: position.speed,
          reginalText: returnS2TAddressInvalid.result?.reginalText,
          translatedText: returnS2TAddressInvalid.result?.translatedText,
          audioS3Path: returnS2TAddressInvalid.result?.audioS3Path,
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
    Map<String, dynamic> postResult = {'success': false};
    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      await FirebaseUtils.storeEvents(
              eventsDetails: requestBodyData.toJson(),
              caseId: caseId,
              selectedClipValue: ConvertString.convertLanguageToConstant(
                  selectedClipValue, context),
              bloc: this)
          .then((value) {
        postResult = {'success': true};
      });
    } else {
      // For local storage purpose storing while online
      await FirebaseUtils.storeEvents(
          eventsDetails: requestBodyData.toJson(),
          caseId: caseId,
          selectedClipValue: ConvertString.convertLanguageToConstant(
              selectedClipValue, context),
          bloc: this);
      postResult = await APIRepository.apiRequest(
        APIRequestType.post,
        urlString,
        requestBodydata: jsonEncode(requestBodyData),
      );
    }
    if (await postResult[Constants.success]) {
      submitedEventType = 'Address Invalid';
      isSubmitedForMyVisits = true;
      isEventSubmited = true;
      caseDetailsAPIValue.result?.caseDetails?.collSubStatus =
          ConvertString.convertLanguageToConstant(selectedClipValue, context);
      addressInvalidRemarksController.text = '';
      addressSelectedInvalidClip = '';
    }
    return postResult;
  }

  // user via from call details
  Future<Map<String, dynamic>> phoneInvalidButtonClick(
    String eventType,
    String caseId,
    String urlString,
    String selectedClipValue,
    BuildContext context,
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
          reginalText: returnS2TPhoneInvalid.result?.reginalText,
          translatedText: returnS2TPhoneInvalid.result?.translatedText,
          audioS3Path: returnS2TPhoneInvalid.result?.audioS3Path,
        ),
        eventModule: 'Telecalling',
        contact: PhoneInvalidContact(
          cType: indexValue != null
              ? caseDetailsAPIValue.result?.callDetails![indexValue!]['cType']
              : caseDetailsAPIValue
                  .result?.callDetails![paramValue['contactIndex']]['cType'],
          value: indexValue != null
              ? caseDetailsAPIValue.result?.callDetails![indexValue!]['value']
              : caseDetailsAPIValue
                  .result?.callDetails![paramValue['contactIndex']]['value'],
          health: ConstantEventValues.phoneInvalidHealth,
          contactId0: Singleton.instance.contactId_0 ?? '',
        ));

    Map<String, dynamic> postResult = {'success': false};
    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      await FirebaseUtils.storeEvents(
              eventsDetails: requestBodyData.toJson(),
              caseId: caseId,
              selectedClipValue: ConvertString.convertLanguageToConstant(
                  selectedClipValue, context),
              bloc: this)
          .then((value) {
        postResult = {'success': true};
      });
    } else {
      // For local storage purpose storing while online
      await FirebaseUtils.storeEvents(
          eventsDetails: requestBodyData.toJson(),
          caseId: caseId,
          selectedClipValue: ConvertString.convertLanguageToConstant(
              selectedClipValue, context),
          bloc: this);
      postResult = await APIRepository.apiRequest(
        APIRequestType.post,
        urlString,
        requestBodydata: jsonEncode(requestBodyData),
      );
    }

    if (await postResult[Constants.success]) {
      isSubmitedForMyVisits = true;
      submitedEventType = 'Phone Invalid';
      if (userType == Constants.telecaller) {
        isEventSubmited = true;
      }
      if (Singleton.instance.usertype == Constants.telecaller) {
        caseDetailsAPIValue.result?.caseDetails?.telSubStatus =
            ConvertString.convertLanguageToConstant(selectedClipValue, context);
      } else {
        caseDetailsAPIValue.result?.caseDetails?.collSubStatus =
            selectedClipValue;
      }
      phoneInvalidRemarksController.text = '';
      phoneSelectedInvalidClip = '';
    }
    return postResult;
  }
}
