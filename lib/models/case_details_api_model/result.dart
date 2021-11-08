import 'case_details.dart';
import 'other_loan_detail.dart';

class Result {
  CaseDetails? caseDetails;
  List<dynamic>? addressDetails;
  List<dynamic>? callDetails;
  List<OtherLoanDetail>? otherLoanDetails;

  Result({
    this.caseDetails,
    this.addressDetails,
    this.callDetails,
    this.otherLoanDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        caseDetails: json['caseDetails'] == null
            ? null
            : CaseDetails.fromJson(json['caseDetails'] as Map<String, dynamic>),
        addressDetails: json['addressDetails'] as List<dynamic>?,
        callDetails: json['callDetails'] as List<dynamic>?,
        otherLoanDetails: (json['otherLoanDetails'] as List<dynamic>?)
            ?.map((e) => OtherLoanDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'caseDetails': caseDetails?.toJson(),
        'addressDetails': addressDetails,
        'callDetails': callDetails,
        'otherLoanDetails': otherLoanDetails?.map((e) => e.toJson()).toList(),
      };
}
