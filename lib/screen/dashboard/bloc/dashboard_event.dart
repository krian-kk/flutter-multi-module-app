part of 'dashboard_bloc.dart';

class DashboardEvent extends BaseEquatable {}

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
  final bool isUnTouched;
  final bool isPriorityFollowUp;
  final bool isBrokenPTP;
  final bool isMyReceipts;
  NavigateCaseDetailEvent({
    this.paramValues,
    this.isUnTouched = false,
    this.isPriorityFollowUp = false,
    this.isBrokenPTP = false,
    this.isMyReceipts = false,
  });
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
  final BuildContext? context;
  PostBankDepositDataEvent({this.postData, this.fileData, this.context});
}

class PostCompanyDepositDataEvent extends DashboardEvent {
  final dynamic postData;
  final List<File>? fileData;
  final BuildContext? context;
  PostCompanyDepositDataEvent({this.postData, this.fileData, this.context});
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

class UpdateUnTouchedCasesEvent extends DashboardEvent {
  final String caseId;
  final dynamic caseAmount;
  UpdateUnTouchedCasesEvent(this.caseId, this.caseAmount);
}

class UpdatePriorityFollowUpCasesEvent extends DashboardEvent {
  final String caseId;
  final dynamic caseAmount;
  UpdatePriorityFollowUpCasesEvent(this.caseId, this.caseAmount);
}

class UpdateMyVisitCasesEvent extends DashboardEvent {
  final String caseId;
  final dynamic caseAmount;
  final bool isNotMyReceipts;
  UpdateMyVisitCasesEvent(this.caseId, this.caseAmount,
      {this.isNotMyReceipts = true});
}

class UpdateMyReceiptsCasesEvent extends DashboardEvent {
  final String caseId;
  final dynamic caseAmount;
  UpdateMyReceiptsCasesEvent(this.caseId, this.caseAmount);
}

class UpdateBrokenCasesEvent extends DashboardEvent {
  final String caseId;
  final dynamic caseAmount;
  UpdateBrokenCasesEvent(this.caseId, this.caseAmount);
}
