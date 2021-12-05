part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends BaseEquatable {}

class DashboardInitialEvent extends DashboardEvent {}

class PriorityFollowEvent extends DashboardEvent {}

class UntouchedCasesEvent extends DashboardEvent {}

class BrokenPTPEvent extends DashboardEvent {}

class MyReceiptsEvent extends DashboardEvent {}

class ReceiptsApiEvent extends DashboardEvent {
  dynamic? timePeiod;
  ReceiptsApiEvent({this.timePeiod});
}

class MyVisitsEvent extends DashboardEvent {
}

class MyVisitApiEvent extends DashboardEvent {
  dynamic? timePeiod;
  MyVisitApiEvent({this.timePeiod});
}
class MyDeposistsEvent extends DashboardEvent {}

class DeposistsApiEvent extends DashboardEvent {
  dynamic? timePeiod;
  DeposistsApiEvent({this.timePeiod});
}


class YardingAndSelfReleaseEvent extends DashboardEvent {}

class NavigateCaseDetailEvent extends DashboardEvent {
  dynamic paramValues;
  NavigateCaseDetailEvent({this.paramValues});
}

class NavigateSearchEvent extends DashboardEvent {}

class SetTimeperiodValueEvent extends DashboardEvent {}

class PostBankDepositDataEvent extends DashboardEvent {
  dynamic postData;
  PostBankDepositDataEvent({this.postData});
}

class PostCompanyDepositDataEvent extends DashboardEvent {
  dynamic postData;
  PostCompanyDepositDataEvent({this.postData});
}

class PostYardingDataEvent extends DashboardEvent {
  dynamic postData;
  PostYardingDataEvent({this.postData});
}

class PostSelfreleaseDataEvent extends DashboardEvent {
  dynamic postData;
  PostSelfreleaseDataEvent({this.postData});
}

class HelpEvent extends DashboardEvent {}

