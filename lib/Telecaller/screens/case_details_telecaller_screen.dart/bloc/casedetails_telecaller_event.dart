part of 'casedetails_telecaller_bloc.dart';

class CasedetailsTelecallerEvent extends BaseEquatable {}

class CaseDetailsTelecallerInitialEvent extends CasedetailsTelecallerEvent {}

class ClickCallBottomSheetTelecallerEvent extends CasedetailsTelecallerEvent {}

class LaunchWhatsappTelecallerEvent extends CasedetailsTelecallerEvent {
  final String whatsappUrlAddress;
  LaunchWhatsappTelecallerEvent(this.whatsappUrlAddress);
}

class LaunchSMSEvent extends CasedetailsTelecallerEvent {}
