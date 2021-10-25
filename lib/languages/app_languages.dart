import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get origa;

  String get splashScreen;

  String get cancel;

  String get search;

  String get searchAllocationDetails;

  String get accountNo;

  String get customerName;

  String get dpdBucket;

  String get status;

  String get pincode;

  String get customerID;

  String get myRecentActivity;

  String get showOnlyTopResults;

  String get new_;

  String get overdueAmount;

  String get loanAmount;

  String get loanDuration;

  String get pos;

  String get schemeCode;

  String get emiStartDate;

  String get bankName;

  String get repaymentInfo;

  String get beneficiaryDetails;

  String get repaymentBankName;

  String get referenceLender;

  String get referenceUrl;

  String get caseDetials;

  String get sendSms;

  String get sendWhatsapp;

  String get otherLoanOf;

  String get debasishPatnaik;

  String get view;

  String get customerMet;

  String get customerNotMet;

  String get invalid;

  String get ptp;

  String get rtp;

  String get dispute;

  String get remainderCb;

  String get collections;

  String get ots;

  String get product;

  String get batchNo;

  String get done;

  String get select;

  String get allocation;

  String get dashboard;

  String get profile;

  String get areYouAtOffice;

  String get yes;

  String get no;

  String get searchbasedOn;

  String get priority;

  String get buildRoute;

  String get mapView;

  String get message;

  String get followUpDate;

  String get error;

  String get homeAddress;

  String get markAsHome;

  String get notification;

  String get changeLanguage;

  String get changePassword;

  String get launguage;

  String get defaultLaunguage;

  String get english;

  String get hindi;

  String get tamil;

  String get kannada;

  String get change;

  String get all;

  String get under5km;

  String get more5km;

  String get read;

  String get addressDetails;

  String get callDetails;

  String get okay;

  String get call;

  String get viewMap;

  String get addAProfilePhoto;

  String get captureImage;

  String get uploadPhoto;

  String get logout;

  String get userName;

  String get password;

  String get signin;

  String get resetPassword;

  String get loginViaDiffrentUser;

  String get hignPriority;

  String get choiceOtherLanguages;

  String get declinedCall;

  String get leftMessage;

  String get doorLocked;

  String get entryRestricted;

  String get addNewContact;

  String get repo;

  String get otherFeedBack;

  String get submit;

  String get nextActionDate;

  String get nextActionTime;

  String get remarks;

  String get ptpDate;

  String get ptpTime;

  String get ptpAmount;

  String get paymentMode;

  String get reference;

  String get amountCollected;

  String get date;

  String get time;

  String get cheque;

  String get otsPaymentDate;

  String get otsProposedAmount;

  String get otsPaymentTime;

  String get rtpDenialReason;

  String get disputeReason;

  String get modelMake;

  String get registrationNo;

  String get chassisNo;

  String get customUpload;

  String get eventDetails;

  String get pickUp;

  String get selfPay;

  String get digital;

  String get qrCode;

  String get wrongAddress;

  String get shifted;

  String get addressNotFound;

  String get callCustomer;

  String get agentContactNo;

  String get customerContactNo;

  String get serviceProvidersList;

  String get callersId;

  String get customerMetCategory;
}
