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
      this.agrRef});

  factory OtherLoanDetail.fromJson(Map<String, dynamic> json) {
    return OtherLoanDetail(
      id: json['_id'] as String?,
      due: json['due'],
      originalDue: json['original_due'],
      odVal: json['odVal'],
      cust: json['cust'] as String?,
      accNo: json['accNo'] as String?,
      caseId: json['caseId'] as String?,
      bankName: json['bankName'] as String?,
      agrRef: json['agrRef'] as String?,
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

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'original_due': originalDue,
        'odVal': odVal,
        'cust': cust,
        'accNo': accNo,
        'caseId': caseId,
        'bankName': bankName,
        'agrRef': agrRef,
      };
}
