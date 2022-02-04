part of 'dashboard_bloc.dart';

class DashboardState extends BaseEquatable {}

class DashboardInitial extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardLoadedState extends DashboardState {}

class PriorityFollowState extends DashboardState {}

class UntouchedCasesState extends DashboardState {}

class BrokenPTPState extends DashboardState {}

class MyReceiptsState extends DashboardState {}

class ReturnReceiptsApiState extends DashboardState {
  final dynamic returnData;
  ReturnReceiptsApiState({this.returnData});
}

class MyVisitsState extends DashboardState {}

class ReturnVisitsApiState extends DashboardState {
  final dynamic returnData;

  ReturnVisitsApiState({this.returnData});
}

class MyDeposistsState extends DashboardState {}

class YardingAndSelfReleaseState extends DashboardState {}

class NavigateCaseDetailState extends DashboardState {
  final dynamic paramValues;
  final bool unTouched;
  NavigateCaseDetailState({this.paramValues, this.unTouched = false});
}

class NavigateSearchState extends DashboardState {}

class GetSearchDataState extends DashboardState {
  final dynamic getReturnValues;
  GetSearchDataState({this.getReturnValues});
}

class SetTimeperiodValueState extends DashboardState {}

class HelpState extends DashboardState {}

class ClickPriorityFollowUpState extends DashboardState {}

class SelectedTimeperiodDataLoadingState extends DashboardState {}

class SelectedTimeperiodDataLoadedState extends DashboardState {}

class PostDataApiSuccessState extends DashboardState {}

class NoInternetConnectionState extends DashboardState {}

class DisableMDBankSubmitBtnState extends DashboardState {}

class EnableMDBankSubmitBtnState extends DashboardState {}

class DisableMDCompanyBranchSubmitBtnState extends DashboardState {}

class EnableMDCompanyBranchSubmitBtnState extends DashboardState {}

class DisableRSYardingSubmitBtnState extends DashboardState {}

class EnableRSYardingSubmitBtnState extends DashboardState {}

class DisableRSSelfReleaseSubmitBtnState extends DashboardState {}

class EnableRSSelfReleaseSubmitBtnState extends DashboardState {}

class UpdateSuccessfulState extends DashboardState {}
