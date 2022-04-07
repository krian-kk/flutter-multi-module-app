part of 'case_details_bloc.dart';

@immutable
class CaseDetailsState extends BaseEquatable {}

class CaseDetailsInitial extends CaseDetailsState {
  CaseDetailsInitial({this.paramValues});
  final dynamic paramValues;
}

class CaseDetailsLoadingState extends CaseDetailsState {}

class CaseDetailsLoadedState extends CaseDetailsState {}

class PhoneBottomSheetLoadingState extends CaseDetailsState {}

class PhoneBottomSheetLoadedState extends CaseDetailsState {}

class CDNoInternetState extends CaseDetailsState {}

class ClickMainAddressBottomSheetState extends CaseDetailsState {
  ClickMainAddressBottomSheetState(this.i, {this.addressModel});
  final int i;
  final dynamic addressModel;
}

class ClickMainCallBottomSheetState extends CaseDetailsState {
  ClickMainCallBottomSheetState(this.i,
      {this.isCallFromCaseDetails = false, this.callId});
  final int i;
  final bool isCallFromCaseDetails;
  final String? callId;
}

class ClickViewMapState extends CaseDetailsState {}

class CallCaseDetailsState extends CaseDetailsState {
  CallCaseDetailsState({this.paramValues});
  final dynamic paramValues;
}

class PushAndPOPNavigationCaseDetailsState extends CaseDetailsState {
  PushAndPOPNavigationCaseDetailsState({this.paramValues});
  final dynamic paramValues;
}

class ClickOpenBottomSheetState extends CaseDetailsState {
  ClickOpenBottomSheetState(
    this.title,
    this.list,
    this.isCall, {
    this.health,
    this.selectedContactNumber,
    this.isCallFromCallDetails = false,
    this.callId,
  });
  final String title;
  final List<dynamic> list;
  final bool? isCall;
  final String? health;
  final String? selectedContactNumber;
  final bool isCallFromCallDetails;
  final String? callId;
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
  GenerateQRcodeState({this.qrUrl});
  final String? qrUrl;
}

class UpdateRefUrlState extends CaseDetailsState {
  UpdateRefUrlState({this.refUrl});
  final String? refUrl;
}

class UpdateHealthStatusState extends CaseDetailsState {
  UpdateHealthStatusState();
}
