class DashboardCardCount {
  DashboardCardCount({this.status, this.message, this.result});

  DashboardCardCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? DashCountResult.fromJson(json['result'])
        : null;
  }
  int? status;
  String? message;
  DashCountResult? result;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class DashCountResult {
  DashCountResult(
      {this.priorityFollowUp,
      this.brokenPtp,
      this.visits,
      this.receipts,
      this.untouched,
      this.mtdCases,
      this.mtdAmount,
      this.met,
      this.notMet,
      this.invalid});

  DashCountResult.fromJson(Map<String, dynamic> json) {
    priorityFollowUp = json['priorityFollowUp'] != null
        ? PriorityFollowUp.fromJson(json['priorityFollowUp'])
        : null;
    brokenPtp = json['brokenPtp'] != null
        ? PriorityFollowUp.fromJson(json['brokenPtp'])
        : null;

    // Here check my visit or my calls data
    visits = json['visits'] != null
        ? PriorityFollowUp.fromJson(json['visits'])
        : json['calls'] != null
            ? PriorityFollowUp.fromJson(json['calls'])
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
    met = json['met'] != null ? PriorityFollowUp.fromJson(json['met']) : null;
    notMet = json['notMet'] != null
        ? PriorityFollowUp.fromJson(json['notMet'])
        : null;
    invalid = json['invalid'] != null
        ? PriorityFollowUp.fromJson(json['invalid'])
        : null;
  }
  PriorityFollowUp? priorityFollowUp;
  PriorityFollowUp? brokenPtp;
  PriorityFollowUp? visits;
  PriorityFollowUp? receipts;
  PriorityFollowUp? untouched;
  MtdCases? mtdCases;
  MtdCases? mtdAmount;
  PriorityFollowUp? met;
  PriorityFollowUp? notMet;
  PriorityFollowUp? invalid;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (priorityFollowUp != null) {
      data['priorityFollowUp'] = priorityFollowUp!.toJson();
    }
    if (brokenPtp != null) {
      data['brokenPtp'] = brokenPtp!.toJson();
    }
    if (visits != null) {
      data['visits'] = visits!.toJson();
    }
    if (receipts != null) {
      data['receipts'] = receipts!.toJson();
    }
    if (untouched != null) {
      data['untouched'] = untouched!.toJson();
    }
    if (mtdCases != null) {
      data['mtdCases'] = mtdCases!.toJson();
    }
    if (mtdAmount != null) {
      data['mtdAmount'] = mtdAmount!.toJson();
    }
    if (met != null) {
      data['met'] = met!.toJson();
    }
    if (notMet != null) {
      data['notMet'] = notMet!.toJson();
    }
    if (invalid != null) {
      data['invalid'] = invalid!.toJson();
    }
    return data;
  }
}

class PriorityFollowUp {
  PriorityFollowUp({this.count, this.totalAmt});

  PriorityFollowUp.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
  }
  int? count;
  dynamic totalAmt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalAmt'] = totalAmt;
    return data;
  }
}

class MtdCases {
  MtdCases({this.completed, this.total});

  MtdCases.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    total = json['total'];
  }
  dynamic completed;
  dynamic total;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = completed;
    data['total'] = total;
    return data;
  }
}
