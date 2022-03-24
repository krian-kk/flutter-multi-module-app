import 'package:flutter/material.dart';
import 'package:origa/models/contractor_detail_model.dart';
import 'package:origa/models/contractor_information_model.dart';

class Singleton {
  //development = 1, uat = 2, production = 3
  int? serverPointingType = 3;
  String baseUrl = '';
  String? accessToken;
  String? refreshToken;
  String? sessionID;
  String? agentRef;
  String? agentName;
  String? agrRef;
  String? contractor;
  String? usertype;
  String? password;
  String? caseCustomerName;
  BuildContext? buildContext;
  ContractorDetailsModel? feedbackTemplate;
  bool? cloudTelephony;
  String? overDueAmount;

  // Localstorage for call details
  String? callID;
  String? callingID;
  String? callerServiceID;
  String? resAddressId_0;
  String? contactId_0;
  bool? startCalling;
  bool? isOfflineStorageFeatureEnabled = false;
  String firebaseDatabaseName = 'origaOfflineStorage';

// Contractor All Information
  ContractorAllInformationModel? contractorInformations;

  //store update health value
  dynamic updateHealthStatus;

  String? customerContactNo;

  static final Singleton instance = Singleton.internal();

  factory Singleton() {
    return instance;
  }

  Singleton.internal();
}
