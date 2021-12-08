part of 'case_details_bloc.dart';

@immutable
class CaseDetailsState extends BaseEquatable {}

class CaseDetailsInitial extends CaseDetailsState {
  final dynamic paramValues;
  CaseDetailsInitial({this.paramValues});
}

class CaseDetailsLoadingState extends CaseDetailsState {}

class CaseDetailsLoadedState extends CaseDetailsState {}

class NoInternetState extends CaseDetailsState {}

class ClickMainAddressBottomSheetState extends CaseDetailsState {
  final int i;
  ClickMainAddressBottomSheetState(this.i);
}

class ClickMainCallBottomSheetState extends CaseDetailsState {
  final int i;
  ClickMainCallBottomSheetState(this.i);
}

class ClickAddAddressState extends CaseDetailsState {}

class ClickViewMapState extends CaseDetailsState {}

class NoInternetConnectionState extends CaseDetailsState {}

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
  ClickOpenBottomSheetState(this.title, this.list);
}

class PostDataApiSuccessState extends CaseDetailsState {}
