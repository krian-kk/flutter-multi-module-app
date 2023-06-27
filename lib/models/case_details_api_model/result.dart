import 'package:origa/models/case_details_api_model/case_details_api_model.dart';

import 'case_details.dart';
import 'other_loan_detail.dart';

class CaseDetailsResultModel {
  CaseDetailsResultModel(
      {this.caseDetails,
      this.addressDetails,
      this.callDetails,
      this.otherLoanDetails,
      this.bucketedCaseData,
      this.availableAddContacts});

  factory CaseDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      CaseDetailsResultModel(
        caseDetails: json['caseDetails'] == null
            ? null
            : CaseDetails.fromJson(
                Map<String, dynamic>.from(json['caseDetails'])),
        addressDetails: json['addressDetails'] as List<dynamic>?,
        callDetails: json['callDetails'] as List<dynamic>?,
        bucketedCaseData: json['bucketedCaseData'],
        otherLoanDetails: json['otherLoanDetails'] != null
            ? (json['otherLoanDetails'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    OtherLoanDetail.fromJson(Map<String, dynamic>.from(e)))
                .take(25)
                .toList()
            : <OtherLoanDetail>[],
        availableAddContacts: json['availableAddContacts'] != null
            ? (json['availableAddContacts'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    AvailableAddContacts.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <AvailableAddContacts>[],
      );
  CaseDetails? caseDetails;
  Map<String, dynamic>? bucketedCaseData;
  List<dynamic>? addressDetails;
  List<dynamic>? callDetails;
  List<OtherLoanDetail>? otherLoanDetails = <OtherLoanDetail>[];
  List<AvailableAddContacts>? availableAddContacts = <AvailableAddContacts>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'caseDetails': caseDetails?.toJson(),
        'addressDetails': addressDetails,
        'callDetails': callDetails,
        'bucketedCaseData': bucketedCaseData,
        'otherLoanDetails':
            otherLoanDetails?.map((OtherLoanDetail e) => e.toJson()).toList(),
      };
}

class AvailableAddContacts {
  String? cType;
  String? cName;
  String? type;

  AvailableAddContacts({this.cType, this.cName, this.type});

  AvailableAddContacts.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    cName = json['cName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cType'] = this.cType;
    data['cName'] = this.cName;
    data['type'] = this.type;
    return data;
  }
}
