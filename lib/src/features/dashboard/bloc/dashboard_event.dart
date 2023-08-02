part of 'dashboard_bloc.dart';

class DashboardEvent extends BaseEquatable {}

class DashboardInitialEvent extends DashboardEvent {
  DashboardInitialEvent();
}

class PriorityFollowEvent extends DashboardEvent {}

class UntouchedCasesEvent extends DashboardEvent {}

class BrokenPTPEvent extends DashboardEvent {}

class MyReceiptsEvent extends DashboardEvent {}

class ReceiptsApiEvent extends DashboardEvent {
  ReceiptsApiEvent({this.timePeriod});

  final dynamic timePeriod;
}

class MyVisitsEvent extends DashboardEvent {}

class MyVisitApiEvent extends DashboardEvent {
  MyVisitApiEvent({this.timePeriod});

  final dynamic timePeriod;
}

class MyDepositsEvent extends DashboardEvent {}

class DepositsApiEvent extends DashboardEvent {
  DepositsApiEvent({this.timePeriod});

  final dynamic timePeriod;
}

class YardingAndSelfReleaseEvent extends DashboardEvent {}

class NavigateCaseDetailEvent extends DashboardEvent {
  NavigateCaseDetailEvent({
    this.paramValues,
    this.isUnTouched = false,
    this.isPriorityFollowUp = false,
    this.isBrokenPTP = false,
    this.isMyReceipts = false,
  });

  final dynamic paramValues;
  final bool isUnTouched;
  final bool isPriorityFollowUp;
  final bool isBrokenPTP;
  final bool isMyReceipts;
}

class NavigateSearchEvent extends DashboardEvent {}

class SearchReturnDataEvent extends DashboardEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}

class SetTimePeriodValueEvent extends DashboardEvent {}

class PostBankDepositDataEvent extends DashboardEvent {
  PostBankDepositDataEvent({this.postData, this.fileData, this.context});

  final dynamic postData;
  final List<File>? fileData;
  final BuildContext? context;
}

class PostCompanyDepositDataEvent extends DashboardEvent {
  PostCompanyDepositDataEvent({this.postData, this.fileData, this.context});

  final dynamic postData;
  final List<File>? fileData;
  final BuildContext? context;
}

class PostYardingDataEvent extends DashboardEvent {
  PostYardingDataEvent({this.postData, this.fileData});

  final dynamic postData;
  final List<File>? fileData;
}

class PostSelfReleaseDataEvent extends DashboardEvent {
  PostSelfReleaseDataEvent({this.postData, this.fileData});

  final dynamic postData;
  final List<File>? fileData;
}

class HelpEvent extends DashboardEvent {}

class UpdateUnTouchedCasesEvent extends DashboardEvent {
  UpdateUnTouchedCasesEvent(this.caseId, this.caseAmount);

  final String caseId;
  final dynamic caseAmount;
}

class UpdatePriorityFollowUpCasesEvent extends DashboardEvent {
  UpdatePriorityFollowUpCasesEvent(this.caseId, this.caseAmount);

  final String caseId;
  final dynamic caseAmount;
}

class UpdateMyVisitCasesEvent extends DashboardEvent {
  UpdateMyVisitCasesEvent(this.caseId, this.caseAmount,
      {this.isNotMyReceipts = true});

  final String caseId;
  final dynamic caseAmount;
  final bool isNotMyReceipts;
}

class UpdateMyReceiptsCasesEvent extends DashboardEvent {
  UpdateMyReceiptsCasesEvent(this.caseId, this.caseAmount);

  final String caseId;
  final dynamic caseAmount;
}

class UpdateBrokenCasesEvent extends DashboardEvent {
  UpdateBrokenCasesEvent(this.caseId, this.caseAmount);

  final String caseId;
  final dynamic caseAmount;
}

class AddFilterTimePeriodFromNotification extends DashboardEvent {
  AddFilterTimePeriodFromNotification(this.context);

  final BuildContext? context;
}
