part of 'case_details_bloc.dart';

@immutable
class CaseDetailsState extends BaseEquatable {}

class CaseDetailsInitial extends CaseDetailsState {
  final dynamic paramValues;
  CaseDetailsInitial({this.paramValues});
}

class CaseDetailsLoadingState extends CaseDetailsState {}

class CaseDetailsLoadedState extends CaseDetailsState {}

class CDNoInternetState extends CaseDetailsState {}

class ClickMainAddressBottomSheetState extends CaseDetailsState {
  final int i;
  ClickMainAddressBottomSheetState(this.i);
}

class ClickMainCallBottomSheetState extends CaseDetailsState {
  final int i;
  ClickMainCallBottomSheetState(this.i);
}

class ClickViewMapState extends CaseDetailsState {}

// class CDNoInternetConnectionState extends CaseDetailsState {}

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
  ClickOpenBottomSheetState(this.title, this.list, this.isCall, {this.health});
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

class UpdateHealthStatusState extends CaseDetailsState {
  // final BuildContext context;
  // final int? selectedHealthIndex;
  // final int? tabIndex;
  // final dynamic currentHealth;
  UpdateHealthStatusState(
      // this.context,
      //   {this.selectedHealthIndex, this.tabIndex, this.currentHealth}
      );
}
