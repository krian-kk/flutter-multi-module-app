import 'case_details.dart';
import 'other_loan_detail.dart';

class CaseDetailsResultModel {
  CaseDetailsResultModel({
    this.caseDetails,
    this.addressDetails,
    this.callDetails,
    this.otherLoanDetails,
  });

  factory CaseDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      CaseDetailsResultModel(
        caseDetails: json['caseDetails'] == null
            ? null
            : CaseDetails.fromJson(
                Map<String, dynamic>.from(json['caseDetails'])),
        addressDetails: json['addressDetails'] as List<dynamic>?,
        callDetails: json['callDetails'] as List<dynamic>?,
        otherLoanDetails: json['otherLoanDetails'] != null
            ? (json['otherLoanDetails'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    OtherLoanDetail.fromJson(Map<String, dynamic>.from(e)))
                .take(25)
                .toList()
            : <OtherLoanDetail>[],
      );
  CaseDetails? caseDetails;
  List<dynamic>? addressDetails;
  List<dynamic>? callDetails;
  List<OtherLoanDetail>? otherLoanDetails = <OtherLoanDetail>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'caseDetails': caseDetails?.toJson(),
        'addressDetails': addressDetails,
        'callDetails': callDetails,
        'otherLoanDetails':
            otherLoanDetails?.map((OtherLoanDetail e) => e.toJson()).toList(),
      };
}
