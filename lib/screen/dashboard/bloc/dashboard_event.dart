part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends BaseEquatable {}

class DashboardInitialEvent extends DashboardEvent {}

class PriorityFollowEvent extends DashboardEvent {}

class UntouchedCasesEvent extends DashboardEvent {}

class BrokenPTPEvent extends DashboardEvent {}

class MyReceiptsEvent extends DashboardEvent {}

class MyVisitsEvent extends DashboardEvent {}

class MyDeposistsEvent extends DashboardEvent {}

class YardingAndSelfReleaseEvent extends DashboardEvent {}

class NavigateCaseDetailEvent extends DashboardEvent {

  dynamic paramValues;
  NavigateCaseDetailEvent({this.paramValues});
}

class NavigateSearchEvent extends DashboardEvent {}

class HelpEvent extends DashboardEvent {}
