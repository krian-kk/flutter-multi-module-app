import 'case.dart';

class Approved {
  Approved({this.count, this.totalAmt, this.cases});

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'] as int?,
        cases: (json['cases'] as List<dynamic>?)
            ?.map((dynamic e) =>
                ReceiptWeeklyCase.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  int? count;
  int? totalAmt;
  List<ReceiptWeeklyCase>? cases;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases?.map((ReceiptWeeklyCase e) => e.toJson()).toList(),
      };
}
