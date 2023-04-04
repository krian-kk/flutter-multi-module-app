import 'package:origa/models/case_details_api_model/case_details_api_model.dart';

import 'case_details.dart';
import 'other_loan_detail.dart';

class CaseDetailsResultModel {
  CaseDetailsResultModel(
      {this.caseDetails,
      this.addressDetails,
      this.callDetails,
      this.otherLoanDetails,
      this.bucketedCaseData});

  factory CaseDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      CaseDetailsResultModel(
        caseDetails: json['caseDetails'] == null
            ? null
            : CaseDetails.fromJson(
                Map<String, dynamic>.from(json['caseDetails'])),
        addressDetails: json['addressDetails'] as List<dynamic>?,
        callDetails: json['callDetails'] as List<dynamic>?,
        bucketedCaseData: json['bucketedCaseData'] == null
            ? null
            : CaseDetailModels.fromJson(
                Map<String, dynamic>.from(json['bucketedCaseData'])),
        otherLoanDetails: json['otherLoanDetails'] != null
            ? (json['otherLoanDetails'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    OtherLoanDetail.fromJson(Map<String, dynamic>.from(e)))
                .take(25)
                .toList()
            : <OtherLoanDetail>[],
      );
  CaseDetails? caseDetails;
  CaseDetailModels? bucketedCaseData;
  List<dynamic>? addressDetails;
  List<dynamic>? callDetails;
  List<OtherLoanDetail>? otherLoanDetails = <OtherLoanDetail>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'caseDetails': caseDetails?.toJson(),
        'addressDetails': addressDetails,
        'callDetails': callDetails,
        'bucketedCaseData': bucketedCaseData?.toJson(),
        'otherLoanDetails':
            otherLoanDetails?.map((OtherLoanDetail e) => e.toJson()).toList(),
      };
}
