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

class NavigateCaseDetailEvent extends DashboardEvent {}

class NavigateSearchEvent extends DashboardEvent {}

class HelpEvent extends DashboardEvent {}

class ClickSearchButtonEvent extends DashboardEvent {
  final bool isStaredOnly;
  final String searchField;
  ClickSearchButtonEvent(this.isStaredOnly, this.searchField);
}

class ClickDashboardSearchButtonEvent extends DashboardEvent {
  final bool isStaredOnly;
  final String searchField;
  ClickDashboardSearchButtonEvent(this.isStaredOnly, this.searchField);
}
