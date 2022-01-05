import 'case.dart';

class Result {
  int? count;
  dynamic totalAmt;
  List<Case>? cases;

  Result({this.count, this.totalAmt, this.cases});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'],
        cases: (json['cases'] as List<dynamic>?)
            ?.map((e) => Case.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases?.map((e) => e.toJson()).toList(),
      };
}
