part of 'case_details_bloc.dart';

@immutable
class CaseDetailsEvent extends BaseEquatable {}

class CaseDetailsInitialEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  BuildContext? context;
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
  ClickPhoneInvalidButtonEvent(this.context);
}

class ClickPhoneUnreachableSubmitedButtonEvent extends CaseDetailsEvent {
  final BuildContext context;
  ClickPhoneUnreachableSubmitedButtonEvent(this.context);
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
  ClickOpenBottomSheetEvent(this.title, this.list);
}

class PostImageCapturedEvent extends CaseDetailsEvent {
  final dynamic postData;
  PostImageCapturedEvent({this.postData});
}
