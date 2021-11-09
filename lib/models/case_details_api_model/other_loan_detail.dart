class OtherLoanDetail {
  String? id;
  int? due;
  String? cust;
  String? accNo;

  OtherLoanDetail({this.id, this.due, this.cust, this.accNo});

  factory OtherLoanDetail.fromJson(Map<String, dynamic> json) {
    return OtherLoanDetail(
      id: json['_id'] as String?,
      due: json['due'] as int?,
      cust: json['cust'] as String?,
      accNo: json['accNo'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'cust': cust,
        'accNo': accNo,
      };
}
