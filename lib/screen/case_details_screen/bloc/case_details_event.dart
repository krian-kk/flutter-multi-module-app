part of 'case_details_bloc.dart';

@immutable
class CaseDetailsEvent extends BaseEquatable {}

class CaseDetailsInitialEvent extends CaseDetailsEvent {}

class ClickAddressBottomSheetEvent extends CaseDetailsEvent {}

class ClickCallBottomSheetEvent extends CaseDetailsEvent {}

class LaunchWhatsappEvent extends CaseDetailsEvent {
  final String whatsappUrlAddress;
  LaunchWhatsappEvent(this.whatsappUrlAddress);
}

class LaunchSMSEvent extends CaseDetailsEvent {}

class ClickMainAddressBottomSheetEvent extends CaseDetailsEvent {}

class ClickMainCallBottomSheetEvent extends CaseDetailsEvent {}

class ClickPopEvent extends CaseDetailsEvent {}

class ClickPTPEvent extends CaseDetailsEvent {}

class ClickRTPEvent extends CaseDetailsEvent {}

class ClickDisputeEvent extends CaseDetailsEvent {}

class ClickRemainderEvent extends CaseDetailsEvent {}

class ClickCollectionsEvent extends CaseDetailsEvent {}

class ClickOTSEvent extends CaseDetailsEvent {}

class ClickCaptureImageEvent extends CaseDetailsEvent {}

class ClickRepoEvent extends CaseDetailsEvent {}

class ClickAddAddressEvent extends CaseDetailsEvent {}

class ClickOtherFeedbackEvent extends CaseDetailsEvent {}

class ClickViewMapEvent extends CaseDetailsEvent {}

class ClickEventDetailsEvent extends CaseDetailsEvent {}

class ClickPhoneDetailEvent extends CaseDetailsEvent {}

class ClickCallCustomerEvent extends CaseDetailsEvent {}
