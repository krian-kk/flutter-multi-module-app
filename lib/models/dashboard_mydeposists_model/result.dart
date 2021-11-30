import 'cash.dart';
import 'cheque.dart';

class DashboardMyDeposistsResult {
  int? count;
  int? totalAmt;
  Cheque? cheque;
  Cash? cash;

  DashboardMyDeposistsResult(
      {this.count, this.totalAmt, this.cheque, this.cash});

  factory DashboardMyDeposistsResult.fromJson(Map<String, dynamic> json) =>
      DashboardMyDeposistsResult(
        count: json['count'] as int?,
        totalAmt: json['totalAmt'] as int?,
        cheque: json['cheque'] == null
            ? null
            : Cheque.fromJson(json['cheque'] as Map<String, dynamic>),
        cash: json['cash'] == null
            ? null
            : Cash.fromJson(json['cash'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalAmt': totalAmt,
        'cheque': cheque?.toJson(),
        'cash': cash?.toJson(),
      };
}
