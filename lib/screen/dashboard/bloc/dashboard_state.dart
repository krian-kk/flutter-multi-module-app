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
  ReturnReceiptsApiState({this.returnData});
  final dynamic returnData;
}

class MyVisitsState extends DashboardState {}

class ReturnVisitsApiState extends DashboardState {
  ReturnVisitsApiState({this.returnData});
  final dynamic returnData;
}

class MyDeposistsState extends DashboardState {}

class YardingAndSelfReleaseState extends DashboardState {}

class NavigateCaseDetailState extends DashboardState {
  NavigateCaseDetailState({
    this.paramValues,
    this.unTouched = false,
    this.isPriorityFollowUp = false,
    this.isBrokenPTP = false,
    this.isMyReceipts = false,
  });
  final dynamic paramValues;
  final bool unTouched;
  final bool isPriorityFollowUp;
  final bool isBrokenPTP;
  final bool isMyReceipts;
}

class NavigateSearchState extends DashboardState {}

class GetSearchDataState extends DashboardState {
  GetSearchDataState({this.getReturnValues});
  final dynamic getReturnValues;
}

class SetTimeperiodValueState extends DashboardState {}

class HelpState extends DashboardState {}

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

class ClickToCardLoadingState extends DashboardState {}
