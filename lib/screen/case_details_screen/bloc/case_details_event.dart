part of 'case_details_bloc.dart';

@immutable
class CaseDetailsEvent extends BaseEquatable {}

class CaseDetailsInitialEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  final BuildContext? context;
  CaseDetailsInitialEvent({this.paramValues, this.context});
}

class PhoneBottomSheetInitialEvent extends CaseDetailsEvent {
  final bool isCallFromCaseDetails;
  final String? callId;
  final BuildContext context;
  PhoneBottomSheetInitialEvent({
    this.callId,
    required this.context,
    this.isCallFromCaseDetails = false,
  });
}

class ClickMainAddressBottomSheetEvent extends CaseDetailsEvent {
  final int index;
  ClickMainAddressBottomSheetEvent(this.index);
}

class ClickMainCallBottomSheetEvent extends CaseDetailsEvent {
  final int index;
  final bool isCallFromCaseDetails;
  final String? callId;
  ClickMainCallBottomSheetEvent(this.index,
      {this.isCallFromCaseDetails = false, this.callId});
}

class ClickViewMapEvent extends CaseDetailsEvent {}

class ClickCustomerNotMetButtonEvent extends CaseDetailsEvent {
  final BuildContext context;
  ClickCustomerNotMetButtonEvent(this.context);
}

class ClickAddressInvalidButtonEvent extends CaseDetailsEvent {
  final BuildContext context;
  ClickAddressInvalidButtonEvent(this.context);
}

class ClickPhoneInvalidButtonEvent extends CaseDetailsEvent {
  final BuildContext context;
  final bool autoCallingStopAndSubmit;
  final bool isCallFromCaseDetails;
  final String? callId;
  ClickPhoneInvalidButtonEvent(
    this.context, {
    this.autoCallingStopAndSubmit = true,
    this.isCallFromCaseDetails = false,
    this.callId,
  });
}

class ClickPhoneUnreachableSubmitedButtonEvent extends CaseDetailsEvent {
  final BuildContext context;
  final bool autoCallingStopAndSubmit;
  final bool isCallFromCaseDetails;
  final String? callId;
  ClickPhoneUnreachableSubmitedButtonEvent(
    this.context, {
    this.autoCallingStopAndSubmit = true,
    this.isCallFromCaseDetails = false,
    this.callId,
  });
}

class ClickCaseDetailsEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  ClickCaseDetailsEvent({this.paramValues});
}

class ClickPushAndPOPCaseDetailsEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  ClickPushAndPOPCaseDetailsEvent({this.paramValues});
}

class ClickOpenBottomSheetEvent extends CaseDetailsEvent {
  final String title;
  final List? list;
  final bool? isCall;
  final String? health;
  final BuildContext? context;
  final String? seleectedContactNumber;
  final bool isCallFromCallDetails;
  final String? callId;
  ClickOpenBottomSheetEvent(
    this.title,
    this.list,
    this.isCall, {
    this.health,
    this.context,
    this.seleectedContactNumber,
    this.isCallFromCallDetails = false,
    this.callId,
  });
}

class PostImageCapturedEvent extends CaseDetailsEvent {
  final PostImageCapturedModel? postData;
  final List<File>? fileData;
  PostImageCapturedEvent({this.postData, this.fileData});
}

class AddedNewAddressListEvent extends CaseDetailsEvent {}

class AddedNewCallContactListEvent extends CaseDetailsEvent {}

class ChangeIsSubmitEvent extends CaseDetailsEvent {
  final String selectedClipValue;
  final String? chageFollowUpDate;
  ChangeIsSubmitEvent(
      {required this.selectedClipValue, this.chageFollowUpDate});
}

class ChangeHealthStatusEvent extends CaseDetailsEvent {}

class ChangeIsSubmitForMyVisitEvent extends CaseDetailsEvent {
  final String eventType;
  final dynamic collectionAmount;
  ChangeIsSubmitForMyVisitEvent(this.eventType, {this.collectionAmount});
}

class SendSMSEvent extends CaseDetailsEvent {
  final BuildContext context;
  final String? type;
  SendSMSEvent(this.context, {this.type});
}

class UpdateHealthStatusEvent extends CaseDetailsEvent {
  final BuildContext context;
  final int? selectedHealthIndex;
  final int? tabIndex;
  final dynamic currentHealth;
  UpdateHealthStatusEvent(this.context,
      {this.selectedHealthIndex, this.tabIndex, this.currentHealth});
}

class ChangeFollowUpDateEvent extends CaseDetailsEvent {
  final String? followUpDate;
  ChangeFollowUpDateEvent({this.followUpDate});
}
