import 'case.dart';

class Result {
  Result({this.count, this.totalAmt, this.cases});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        count:
            json['count'] != null ? json['count'] as int? : json['totalCount'],
        totalAmt: json['totalAmt'],
        cases: (json['cases'] as List<dynamic>?)
            ?.map((e) => Case.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  int? count;
  dynamic totalAmt;
  List<Case>? cases;

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases?.map((e) => e.toJson()).toList(),
      };
}
