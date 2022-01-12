part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends BaseEquatable {}

class DashboardInitialEvent extends DashboardEvent {
  final BuildContext? context;
  DashboardInitialEvent(this.context);
}

class PriorityFollowEvent extends DashboardEvent {}

class UntouchedCasesEvent extends DashboardEvent {}

class BrokenPTPEvent extends DashboardEvent {}

class MyReceiptsEvent extends DashboardEvent {}

class ReceiptsApiEvent extends DashboardEvent {
  final dynamic timePeiod;
  ReceiptsApiEvent({this.timePeiod});
}

class MyVisitsEvent extends DashboardEvent {}

class MyVisitApiEvent extends DashboardEvent {
  final dynamic timePeiod;
  MyVisitApiEvent({this.timePeiod});
}

class MyDeposistsEvent extends DashboardEvent {}

class DeposistsApiEvent extends DashboardEvent {
  final dynamic timePeiod;
  DeposistsApiEvent({this.timePeiod});
}

class YardingAndSelfReleaseEvent extends DashboardEvent {}

class NavigateCaseDetailEvent extends DashboardEvent {
  final dynamic paramValues;
  NavigateCaseDetailEvent({this.paramValues});
}

class NavigateSearchEvent extends DashboardEvent {}

class SearchReturnDataEvent extends DashboardEvent {
  final dynamic returnValue;
  SearchReturnDataEvent({this.returnValue});
}

class SetTimeperiodValueEvent extends DashboardEvent {}

class PostBankDepositDataEvent extends DashboardEvent {
  final dynamic postData;
  final List<File>? fileData;
  PostBankDepositDataEvent({this.postData, this.fileData});
}

class PostCompanyDepositDataEvent extends DashboardEvent {
  final dynamic postData;
  final List<File>? fileData;
  PostCompanyDepositDataEvent({this.postData, this.fileData});
}

class PostYardingDataEvent extends DashboardEvent {
  final dynamic postData;
  final List<File>? fileData;
  PostYardingDataEvent({this.postData, this.fileData});
}

class PostSelfreleaseDataEvent extends DashboardEvent {
  final dynamic postData;
  final List<File>? fileData;
  PostSelfreleaseDataEvent({this.postData, this.fileData});
}

class HelpEvent extends DashboardEvent {}

class NoInternetConnectionEvent extends DashboardEvent {}
