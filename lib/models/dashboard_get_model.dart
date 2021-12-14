class DashboardModel {
  int? status;
  String? message;
  Result? result;

  DashboardModel({this.status, this.message, this.result});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = result?.toJson();
    }
    return data;
  }
}

class Result {
  PriorityFollowUp? priorityFollowUp;
  PriorityFollowUp? brokenPtp;
  PriorityFollowUp? visits;
  PriorityFollowUp? receipts;
  PriorityFollowUp? untouched;
  MtdCases? mtdCases;
  MtdCases? mtdAmount;

  Result(
      {this.priorityFollowUp,
      this.brokenPtp,
      this.visits,
      this.receipts,
      this.untouched,
      this.mtdCases,
      this.mtdAmount});

  Result.fromJson(Map<String, dynamic> json) {
    priorityFollowUp = json['priorityFollowUp'] != null
        ? new PriorityFollowUp.fromJson(json['priorityFollowUp'])
        : null;
    brokenPtp = json['brokenPtp'] != null
        ? new PriorityFollowUp.fromJson(json['brokenPtp'])
        : null;
    visits = json['visits'] != null
        ? new PriorityFollowUp.fromJson(json['visits'])
        : null;
    receipts = json['receipts'] != null
        ? new PriorityFollowUp.fromJson(json['receipts'])
        : null;
    untouched = json['untouched'] != null
        ? new PriorityFollowUp.fromJson(json['untouched'])
        : null;
    mtdCases = json['mtdCases'] != null
        ? new MtdCases.fromJson(json['mtdCases'])
        : null;
    mtdAmount = json['mtdAmount'] != null
        ? new MtdCases.fromJson(json['mtdAmount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priorityFollowUp != null) {
      data['priorityFollowUp'] = this.priorityFollowUp?.toJson();
    }
    if (this.brokenPtp != null) {
      data['brokenPtp'] = brokenPtp?.toJson();
    }
    if (this.visits != null) {
      data['visits'] = this.visits?.toJson();
    }
    if (this.receipts != null) {
      data['receipts'] = this.receipts?.toJson();
    }
    if (this.untouched != null) {
      data['untouched'] = this.untouched?.toJson();
    }
    if (this.mtdCases != null) {
      data['mtdCases'] = this.mtdCases?.toJson();
    }
    if (this.mtdAmount != null) {
      data['mtdAmount'] = this.mtdAmount?.toJson();
    }
    return data;
  }
}

class PriorityFollowUp {
  int? count;
  int? totalAmt;

  PriorityFollowUp({this.count, this.totalAmt});

  PriorityFollowUp.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalAmt'] = this.totalAmt;
    return data;
  }
}

class MtdCases {
  int? completed;
  int? total;

  MtdCases({this.completed, this.total});

  MtdCases.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completed'] = this.completed;
    data['total'] = this.total;
    return data;
  }
}
