class DashboardUntouchedResultModel {
  int? count;
  int? totalAmt;
  List<dynamic>? cases;

  DashboardUntouchedResultModel({this.count, this.totalAmt, this.cases});

  factory DashboardUntouchedResultModel.fromJson(Map<String, dynamic> json) =>
      DashboardUntouchedResultModel(
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
