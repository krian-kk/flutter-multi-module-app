part of 'case_details_bloc.dart';

@immutable
class CaseDetailsEvent extends BaseEquatable {}

class CaseDetailsInitialEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  CaseDetailsInitialEvent({this.paramValues});
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

// class ClickCallCustomerEvent extends CaseDetailsEvent {}

class ClickCaseDetailsEvent extends CaseDetailsEvent {
  final dynamic paramValues;
  ClickCaseDetailsEvent({this.paramValues});
}

class ClickOpenBottomSheetEvent extends CaseDetailsEvent {
  final String title;
  ClickOpenBottomSheetEvent(this.title);
}
