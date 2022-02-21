part of 'telecaller_phone_bloc.dart';

@immutable
class TelecallerPhoneState extends BaseEquatable {}

class TelecallerPhoneInitial extends TelecallerPhoneState {}

class TelecallerPhoneLoadingState extends TelecallerPhoneState {}

class TelecallerPhoneLoadedState extends TelecallerPhoneState {}

class TcNoInternetState extends TelecallerPhoneState {}

// class ClickMainAddressBottomSheetState extends CaseDetailsState {
//   final int i;
//   ClickMainAddressBottomSheetState(this.i);
// }

// class ClickMainCallBottomSheetState extends CaseDetailsState {
//   final int i;
//   ClickMainCallBottomSheetState(this.i);
// }

// class ClickAddAddressState extends CaseDetailsState {}

// class ClickViewMapState extends CaseDetailsState {}

// // class CDNoInternetConnectionState extends CaseDetailsState {}

// class CallCaseDetailsState extends CaseDetailsState {
//   final dynamic paramValues;
//   CallCaseDetailsState({this.paramValues});
// }

// class PushAndPOPNavigationCaseDetailsState extends CaseDetailsState {
//   final dynamic paramValues;
//   PushAndPOPNavigationCaseDetailsState({this.paramValues});
// }

class TcClickOpenBottomSheetState extends TelecallerPhoneState {
  final String title;
  final List list;
  final bool? isCall;
  final String? health;
  TcClickOpenBottomSheetState(this.title, this.list, this.isCall,
      {this.health});
}

class TcPostDataApiSuccessState extends TelecallerPhoneState {}

class TcEnableUnreachableBtnState extends TelecallerPhoneState {}

class TcDisableUnreachableBtnState extends TelecallerPhoneState {}

class TcEnablePhoneInvalidBtnState extends TelecallerPhoneState {}

class TcDisablePhoneInvalidBtnState extends TelecallerPhoneState {}

// class EnableCustomerNotMetBtnState extends CaseDetailsState {}

// class DisableCustomerNotMetBtnState extends CaseDetailsState {}

// class EnableAddressInvalidBtnState extends CaseDetailsState {}

// class DisableAddressInvalidBtnState extends CaseDetailsState {}

// class EnableCaptureImageBtnState extends CaseDetailsState {}

// class DisableCaptureImageBtnState extends CaseDetailsState {}

// class AddedNewAddressListState extends CaseDetailsState {}

// class AddedNewCallContactListState extends CaseDetailsState {}

// class PhoneBottomSheetSuccessState extends CaseDetailsState {}

// class UpdateSuccessfullState extends CaseDetailsState {}

// class UpdateHealthStatusState extends CaseDetailsState {
//   // final BuildContext context;
//   // final int? selectedHealthIndex;
//   // final int? tabIndex;
//   // final dynamic currentHealth;
//   UpdateHealthStatusState(
//       // this.context,
//       //   {this.selectedHealthIndex, this.tabIndex, this.currentHealth}
//       );
// }
