import 'case.dart';

class New {
  int? count;
  int? totalAmt;
  List<ReceiptWeeklyCase>? cases;

  New({this.count, this.totalAmt, this.cases});

  factory New.fromJson(Map<String, dynamic> json) => New(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'] as int?,
        cases: (json['cases'] as List<dynamic>?)
            ?.map((e) => ReceiptWeeklyCase.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases?.map((e) => e.toJson()).toList(),
      };
}
