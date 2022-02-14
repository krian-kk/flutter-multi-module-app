part of 'case_details_bloc.dart';

@immutable
class CaseDetailsEvent extends BaseEquatable {}

class CaseDetailsInitialEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  final BuildContext? context;
  CaseDetailsInitialEvent({this.paramValues, this.context});
}

class LaunchWhatsappEvent extends CaseDetailsEvent {
  final String whatsappUrlAddress;
  LaunchWhatsappEvent(this.whatsappUrlAddress);
}

class LaunchSMSEvent extends CaseDetailsEvent {}

class ClickMainAddressBottomSheetEvent extends CaseDetailsEvent {
  final int index;
  ClickMainAddressBottomSheetEvent(this.index);
}

class ClickMainCallBottomSheetEvent extends CaseDetailsEvent {
  final int index;
  ClickMainCallBottomSheetEvent(this.index);
}

class ClickViewMapEvent extends CaseDetailsEvent {}

class ClickUnreachableButtonEvent extends CaseDetailsEvent {}

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
  ClickPhoneInvalidButtonEvent(this.context,
      {this.autoCallingStopAndSubmit = true});
}

class ClickPhoneUnreachableSubmitedButtonEvent extends CaseDetailsEvent {
  final BuildContext context;
  final bool autoCallingStopAndSubmit;
  ClickPhoneUnreachableSubmitedButtonEvent(this.context,
      {this.autoCallingStopAndSubmit = true});
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
  ClickOpenBottomSheetEvent(this.title, this.list, this.isCall,
      {this.health, this.context});
}

class PostImageCapturedEvent extends CaseDetailsEvent {
  final PostImageCapturedModel? postData;
  final List<File>? fileData;
  PostImageCapturedEvent({this.postData, this.fileData});
}

class EnableUnreachableBtnEvent extends CaseDetailsEvent {}

class DisableUnreachableBtnEvent extends CaseDetailsEvent {}

class EnablePhoneInvalidBtnEvent extends CaseDetailsEvent {}

class DisablePhoneInvalidBtnEvent extends CaseDetailsEvent {}

class AddedNewAddressListEvent extends CaseDetailsEvent {}

class AddedNewCallContactListEvent extends CaseDetailsEvent {}

class ChangeIsSubmitEvent extends CaseDetailsEvent {}

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
