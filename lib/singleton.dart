import 'package:flutter/material.dart';
import 'package:origa/models/contractor_detail_model.dart';
import 'package:origa/models/contractor_information_model.dart';

class Singleton {
  factory Singleton() {
    return instance;
  }

  Singleton.internal();

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
  bool charScreenFromNotification = false;

  // Localstorage for call details
  String? callID;
  String? callingID;
  String? callerServiceID;
  String? invalidNumber;
  String? resAddressId_0;
  String? contactId_0;
  bool? startCalling;
  bool isOfflineStorageFeatureEnabled = false;
  bool isFirstTime = true;
  String firebaseDatabaseName = 'origaOfflineStorage';

// Contractor All Information
  ContractorAllInformationModel? contractorInformations;

  //store update health value
  dynamic updateHealthStatus;

  String? customerContactNo;

  bool isMPin = false;

  static final Singleton instance = Singleton.internal();
}
