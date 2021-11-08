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

class MyVisitsState extends DashboardState {}

class MyDeposistsState extends DashboardState {}

class YardingAndSelfReleaseState extends DashboardState {}

class HelpState extends DashboardState {}
