part of 'case_details_bloc.dart';

@immutable
class CaseDetailsState extends BaseEquatable {}

class CaseDetailsInitial extends CaseDetailsState {
  final dynamic paramValues;
  CaseDetailsInitial({this.paramValues});
}

class CaseDetailsLoadingState extends CaseDetailsState {}

class CaseDetailsLoadedState extends CaseDetailsState {}

class PhoneBottomSheetLoadingState extends CaseDetailsState {}

class PhoneBottomSheetLoadedState extends CaseDetailsState {}

class CDNoInternetState extends CaseDetailsState {}

class ClickMainAddressBottomSheetState extends CaseDetailsState {
  final int i;
  dynamic addressModel;
  ClickMainAddressBottomSheetState(this.i,{this.addressModel});
}

class ClickMainCallBottomSheetState extends CaseDetailsState {
  final int i;
  final bool isCallFromCaseDetails;
  final String? callId;
  ClickMainCallBottomSheetState(this.i,
      {this.isCallFromCaseDetails = false, this.callId});
}

class ClickViewMapState extends CaseDetailsState {}

class CallCaseDetailsState extends CaseDetailsState {
  final dynamic paramValues;
  CallCaseDetailsState({this.paramValues});
}

class PushAndPOPNavigationCaseDetailsState extends CaseDetailsState {
  final dynamic paramValues;
  PushAndPOPNavigationCaseDetailsState({this.paramValues});
}

class ClickOpenBottomSheetState extends CaseDetailsState {
  final String title;
  final List list;
  final bool? isCall;
  final String? health;
  final String? selectedContactNumber;
  final bool isCallFromCallDetails;
  final String? callId;
  ClickOpenBottomSheetState(
    this.title,
    this.list,
    this.isCall, {
    this.health,
    this.selectedContactNumber,
    this.isCallFromCallDetails = false,
    this.callId,
  });
}

class PostDataApiSuccessState extends CaseDetailsState {}

class EnableUnreachableBtnState extends CaseDetailsState {}

class DisableUnreachableBtnState extends CaseDetailsState {}

class EnablePhoneInvalidBtnState extends CaseDetailsState {}

class DisablePhoneInvalidBtnState extends CaseDetailsState {}

class EnableCustomerNotMetBtnState extends CaseDetailsState {}

class DisableCustomerNotMetBtnState extends CaseDetailsState {}

class EnableAddressInvalidBtnState extends CaseDetailsState {}

class DisableAddressInvalidBtnState extends CaseDetailsState {}

class EnableCaptureImageBtnState extends CaseDetailsState {}

class DisableCaptureImageBtnState extends CaseDetailsState {}

class AddedNewAddressListState extends CaseDetailsState {}

class AddedNewCallContactListState extends CaseDetailsState {}

class PhoneBottomSheetSuccessState extends CaseDetailsState {}

class UpdateSuccessfullState extends CaseDetailsState {}

class SendSMSloadState extends CaseDetailsState {}

class GenerateQRcodeState extends CaseDetailsState {
  final String? qrUrl;
  GenerateQRcodeState({this.qrUrl});
}

class UpdateRefUrlState extends CaseDetailsState {
  final String? refUrl;
  UpdateRefUrlState({this.refUrl});
}

class UpdateHealthStatusState extends CaseDetailsState {
  UpdateHealthStatusState();
}
