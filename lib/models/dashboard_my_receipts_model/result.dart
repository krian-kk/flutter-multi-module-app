class DashboardMyReceiptsResult {
  DashboardMyReceiptsResult({this.count, this.totalAmt, this.cases});

  factory DashboardMyReceiptsResult.fromJson(Map<String, dynamic> json) =>
      DashboardMyReceiptsResult(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'] as int?,
        cases: json['cases'] as List<dynamic>?,
      );
  int? count;
  int? totalAmt;
  List<dynamic>? cases;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases,
      };
}
