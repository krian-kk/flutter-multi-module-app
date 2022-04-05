import 'approved.dart';
import 'case.dart';
import 'new.dart';
import 'receipt_event.dart';
import 'rejected.dart';

class Result {
  Result({
    this.totalCount,
    this.totalAmt,
    this.receiptEvent,
    this.cases,
    this.approved,
    this.rejected,
    this.new_,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        totalCount: json['totalCount'] as int?,
        totalAmt: json['totalAmt'] as int?,
        receiptEvent: (json['receiptEvent'] as List<dynamic>?)
            ?.map((e) => ReceiptEvent.fromJson(e as Map<String, dynamic>))
            .toList(),
        cases: (json['cases'] as List<dynamic>?)
            ?.map((e) => ReceiptWeeklyCase.fromJson(e as Map<String, dynamic>))
            .toList(),
        approved: json['approved'] == null
            ? null
            : Approved.fromJson(json['approved'] as Map<String, dynamic>),
        rejected: json['rejected'] == null
            ? null
            : Rejected.fromJson(json['rejected'] as Map<String, dynamic>),
        new_: json['new'] == null
            ? null
            : New.fromJson(json['new'] as Map<String, dynamic>),
      );
  int? totalCount;
  int? totalAmt;
  List<ReceiptEvent>? receiptEvent;
  List<ReceiptWeeklyCase>? cases;
  Approved? approved;
  Rejected? rejected;
  New? new_;

  Map<String, dynamic> toJson() => {
        'totalCount': totalCount,
        'totalAmt': totalAmt,
        'receiptEvent': receiptEvent?.map((e) => e.toJson()).toList(),
        'cases': cases?.map((e) => e.toJson()).toList(),
        'approved': approved?.toJson(),
        'rejected': rejected?.toJson(),
        'new': new_?.toJson(),
      };
}
