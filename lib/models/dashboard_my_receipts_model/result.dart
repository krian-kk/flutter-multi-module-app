class DashboardMyReceiptsResult {
  int? count;
  int? totalAmt;
  List<dynamic>? cases;

  DashboardMyReceiptsResult({this.count, this.totalAmt, this.cases});

  factory DashboardMyReceiptsResult.fromJson(Map<String, dynamic> json) =>
      DashboardMyReceiptsResult(
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
