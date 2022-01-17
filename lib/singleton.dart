import 'package:flutter/material.dart';
import 'package:origa/models/contractor_detail_model.dart';

class Singleton {
  String? accessToken;
  String? refreshToken;
  String? sessionID;
  String? agentRef;
  String? agentName;
  String? agrRef;
  String? contractor;
  String? usertype;
  String? caseCustomerName;
  BuildContext? buildContext;
  ContractorDetailsModel? feedbackTemplate;
  bool? cloudTelephony;

  // Localstorage for call details
  String? callID;
  String? callingID;
  String? callerServiceID;
  String? resAddressId_0;
  String? contactId_0;

  String? overDueAmount;
  static final Singleton instance = Singleton.internal();

  factory Singleton() {
    return instance;
  }

  Singleton.internal();
}
