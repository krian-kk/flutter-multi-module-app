part of 'case_details_bloc.dart';

@immutable
class CaseDetailsEvent extends BaseEquatable {}

class CaseDetailsInitialEvent extends CaseDetailsEvent {
  CaseDetailsInitialEvent({this.paramValues, this.context});

  final dynamic paramValues;
  final BuildContext? context;
}

class PhoneBottomSheetInitialEvent extends CaseDetailsEvent {
  PhoneBottomSheetInitialEvent({
    this.callId,
    required this.context,
    this.isCallFromCaseDetails = false,
  });

  final bool isCallFromCaseDetails;
  final String? callId;
  final BuildContext context;
}

class ClickMainAddressBottomSheetEvent extends CaseDetailsEvent {
  ClickMainAddressBottomSheetEvent(this.index, {this.addressModel});

  final int index;
  final dynamic addressModel;
}

class ClickMainCallBottomSheetEvent extends CaseDetailsEvent {
  ClickMainCallBottomSheetEvent(this.index,
      {this.isCallFromCaseDetails = false, this.callId});

  final int index;
  final bool isCallFromCaseDetails;
  final String? callId;
}

class ClickViewMapEvent extends CaseDetailsEvent {}

class ClickCustomerNotMetButtonEvent extends CaseDetailsEvent {
  ClickCustomerNotMetButtonEvent(this.context);

  final BuildContext context;
}

class ClickAddressInvalidButtonEvent extends CaseDetailsEvent {
  ClickAddressInvalidButtonEvent(this.context);

  final BuildContext context;
}

class ClickPhoneInvalidButtonEvent extends CaseDetailsEvent {
  ClickPhoneInvalidButtonEvent(
    this.context, {
    this.autoCallingStopAndSubmit = true,
    this.isCallFromCaseDetails = false,
    this.callId,
  });

  final BuildContext context;
  final bool autoCallingStopAndSubmit;
  final bool isCallFromCaseDetails;
  final String? callId;
}

class ClickPhoneUnreachableSubmitedButtonEvent extends CaseDetailsEvent {
  ClickPhoneUnreachableSubmitedButtonEvent(
    this.context, {
    this.autoCallingStopAndSubmit = true,
    this.isCallFromCaseDetails = false,
    this.callId,
  });

  final BuildContext context;
  final bool autoCallingStopAndSubmit;
  final bool isCallFromCaseDetails;
  final String? callId;
}

class ClickCaseDetailsEvent extends CaseDetailsEvent {
  ClickCaseDetailsEvent({this.paramValues});

  final dynamic paramValues;
}

class ClickPushAndPOPCaseDetailsEvent extends CaseDetailsEvent {
  ClickPushAndPOPCaseDetailsEvent({this.paramValues});

  final dynamic paramValues;
}

class EventDetailsEvent extends CaseDetailsEvent {
  EventDetailsEvent(
    this.title,
    this.list,
    this.isCall, {
    this.health,
    this.context,
    this.seleectedContactNumber,
    this.isCallFromCallDetails = false,
    this.callId,
  });

  final String title;
  final List<dynamic>? list;
  final bool? isCall;
  final String? health;
  final BuildContext? context;
  final String? seleectedContactNumber;
  final bool isCallFromCallDetails;
  final String? callId;
}

class PostImageCapturedEvent extends CaseDetailsEvent {
  PostImageCapturedEvent({this.postData, this.fileData, this.context});

  final PostImageCapturedModel? postData;
  final List<File>? fileData;
  final BuildContext? context;
}

class AddedNewAddressListEvent extends CaseDetailsEvent {}

class AddedNewCallContactListEvent extends CaseDetailsEvent {}

class ChangeIsSubmitEvent extends CaseDetailsEvent {
  ChangeIsSubmitEvent(
      {required this.selectedClipValue, this.chageFollowUpDate});

  final String selectedClipValue;
  final String? chageFollowUpDate;
}

class ChangeHealthStatusEvent extends CaseDetailsEvent {}

class ChangeIsSubmitForMyVisitEvent extends CaseDetailsEvent {
  ChangeIsSubmitForMyVisitEvent(this.eventType, {this.collectionAmount});

  final String eventType;
  final dynamic collectionAmount;
}

class SendSMSEvent extends CaseDetailsEvent {
  SendSMSEvent(this.context, {this.type});

  final BuildContext context;
  final String? type;
}

class UpdateHealthStatusEvent extends CaseDetailsEvent {
  UpdateHealthStatusEvent(this.context,
      {this.selectedHealthIndex, this.tabIndex, this.currentHealth});

  final BuildContext context;
  final int? selectedHealthIndex;
  final int? tabIndex;
  final dynamic currentHealth;
}

class ChangeFollowUpDateEvent extends CaseDetailsEvent {
  ChangeFollowUpDateEvent({this.followUpDate});

  final String? followUpDate;
}

class GeneratePaymenLinktEvent extends CaseDetailsEvent {
  GeneratePaymenLinktEvent(this.context, {required this.caseID});

  final BuildContext context;
  final String caseID;
}

class SendWhatsAppEvent extends CaseDetailsEvent {
  SendWhatsAppEvent(this.context, {required this.caseID});
  final BuildContext context;
  final String caseID;
}

class GenerateQRcodeEvent extends CaseDetailsEvent {
  GenerateQRcodeEvent(this.context, {required this.caseID});
  final BuildContext context;
  final String caseID;
}

class FirebaseStream extends CaseDetailsEvent {
  FirebaseStream();
}

class TriggerEventDetailsEvent extends CaseDetailsEvent {}
