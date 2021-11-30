class DashboardMyVistisResult {
  int? count;
  int? totalAmt;
  List<dynamic>? cases;

  DashboardMyVistisResult({this.count, this.totalAmt, this.cases});

  factory DashboardMyVistisResult.fromJson(Map<String, dynamic> json) =>
      DashboardMyVistisResult(
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
