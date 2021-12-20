class DashboardModel {
  int? status;
  String? message;
  Result? result;

  DashboardModel({this.status, this.message, this.result});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
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
        ? PriorityFollowUp.fromJson(json['priorityFollowUp'])
        : null;
    brokenPtp = json['brokenPtp'] != null
        ? PriorityFollowUp.fromJson(json['brokenPtp'])
        : null;
    visits = json['visits'] != null
        ? PriorityFollowUp.fromJson(json['visits'])
        : null;
    receipts = json['receipts'] != null
        ? PriorityFollowUp.fromJson(json['receipts'])
        : null;
    untouched = json['untouched'] != null
        ? PriorityFollowUp.fromJson(json['untouched'])
        : null;
    mtdCases =
        json['mtdCases'] != null ? MtdCases.fromJson(json['mtdCases']) : null;
    mtdAmount =
        json['mtdAmount'] != null ? MtdCases.fromJson(json['mtdAmount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (priorityFollowUp != null) {
      data['priorityFollowUp'] = priorityFollowUp?.toJson();
    }
    if (brokenPtp != null) {
      data['brokenPtp'] = brokenPtp?.toJson();
    }
    if (visits != null) {
      data['visits'] = visits?.toJson();
    }
    if (receipts != null) {
      data['receipts'] = receipts?.toJson();
    }
    if (untouched != null) {
      data['untouched'] = untouched?.toJson();
    }
    if (mtdCases != null) {
      data['mtdCases'] = mtdCases?.toJson();
    }
    if (mtdAmount != null) {
      data['mtdAmount'] = mtdAmount?.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalAmt'] = totalAmt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = completed;
    data['total'] = total;
    return data;
  }
}
