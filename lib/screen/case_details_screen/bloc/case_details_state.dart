part of 'case_details_bloc.dart';

@immutable
class CaseDetailsState extends BaseEquatable {}

class CaseDetailsInitial extends CaseDetailsState {}

class CaseDetailsLoadingState extends CaseDetailsState {}

class CaseDetailsLoadedState extends CaseDetailsState {}

class ClickAddressBottomSheetState extends CaseDetailsState {}

class ClickCallBottomSheetState extends CaseDetailsState {}
