import 'case.dart';

class Approved {
  int? count;
  int? totalAmt;
  List<ReceiptWeeklyCase>? cases;

  Approved({this.count, this.totalAmt, this.cases});

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
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
