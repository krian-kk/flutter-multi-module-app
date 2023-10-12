class OtherLoanDetail {
  OtherLoanDetail(
      {this.id,
      this.due,
      this.originalDue,
      this.odVal,
      this.cust,
      this.accNo,
      this.caseId,
      this.bankName,
      this.agrRef,
      this.supportAllocatedTo,
      this.aRef,
      this.canAccess});

  factory OtherLoanDetail.fromJson(Map<String, dynamic> json) {
    return OtherLoanDetail(
      id: json['_id'] as String?,
      due: json['due'],
      originalDue: json['original_due'],
      odVal: json['odVal'],
      cust: json['cust'] as String?,
      accNo: json['accNo'] != null ? json['accNo'] as String? : ' ',
      caseId: json['caseId'] as String?,
      bankName: json['bankName'] != null ? json['bankName'] as String? : ' ',
      agrRef: json['agrRef'] as String?,
      supportAllocatedTo: json['SupportAllocatedTo'],
      aRef: json['aRef'],
      canAccess: json['canAccess'],
    );
  }
  String? id;
  dynamic due;
  dynamic originalDue;
  dynamic odVal;
  String? cust;
  String? accNo;
  String? caseId;
  String? bankName;
  String? agrRef;
  String? supportAllocatedTo;
  String? aRef;
  bool? canAccess;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'due': due,
        'original_due': originalDue,
        'odVal': odVal,
        'cust': cust,
        'accNo': accNo,
        'caseId': caseId,
        'bankName': bankName,
        'agrRef': agrRef,
        'SupportAllocatedTo': supportAllocatedTo,
        'aRef': aRef,
        'canAccess': canAccess,
      };
}
