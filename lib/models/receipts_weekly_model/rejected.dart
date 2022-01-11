class Rejected {
  int? count;
  int? totalAmt;
  List<dynamic>? cases;

  Rejected({this.count, this.totalAmt, this.cases});

  factory Rejected.fromJson(Map<String, dynamic> json) => Rejected(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'] as int?,
        cases: json['cases'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases,
      };
}
