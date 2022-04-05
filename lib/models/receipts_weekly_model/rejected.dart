class Rejected {
  Rejected({this.count, this.totalAmt, this.cases});

  factory Rejected.fromJson(Map<String, dynamic> json) => Rejected(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'] as int?,
        cases: json['cases'] as List<dynamic>?,
      );
  int? count;
  int? totalAmt;
  List<dynamic>? cases;

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases,
      };
}
