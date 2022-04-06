class DashboardProrityResultModel {
  DashboardProrityResultModel({this.count, this.totalAmt, this.cases});

  factory DashboardProrityResultModel.fromJson(Map<String, dynamic> json) =>
      DashboardProrityResultModel(
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
