class OtherLoanDetail {
  String? id;
  dynamic due;
  String? cust;
  String? accNo;
  String? caseId;

  OtherLoanDetail({this.id, this.due, this.cust, this.accNo, this.caseId});

  factory OtherLoanDetail.fromJson(Map<String, dynamic> json) {
    return OtherLoanDetail(
      id: json['_id'] as String?,
      due: json['due'],
      cust: json['cust'] as String?,
      accNo: json['accNo'] as String?,
      caseId: json['caseId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'cust': cust,
        'accNo': accNo,
        'caseId': caseId,
      };
}
