part of 'case_details_bloc.dart';

@immutable
class CaseDetailsState extends BaseEquatable {}

class CaseDetailsInitial extends CaseDetailsState {}

class CaseDetailsLoadingState extends CaseDetailsState {}

class CaseDetailsLoadedState extends CaseDetailsState {}

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

// class ClickCallCustomerState extends CaseDetailsState {}

class CallCaseDetailsState extends CaseDetailsState {}

class ClickOpenBottomSheetState extends CaseDetailsState {
  final String title;
  ClickOpenBottomSheetState(this.title);
}
