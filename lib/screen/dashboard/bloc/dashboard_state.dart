part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends BaseEquatable {}

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
  NavigateCaseDetailState({this.paramValues});
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
