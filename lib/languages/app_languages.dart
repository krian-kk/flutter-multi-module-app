import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get origa;

  String get splashScreen;

  String get userId;

  String get userName;

  String get password;

  String get signin;

  String get resetPassword;

  String get loginViaDiffrentUser;

  String get hignPriority;

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

  String get change;

  String get all;

  String get under5km;

  String get more5km;

  String get mtdResolutionProgress;

  String get customer;

  String get amount;

  String get priorityFollowUp;

  String get untouchedCases;

  String get brokenPTP;

  String get myReceipts;

  String get myVisits;

  String get myCalls;

  String get myDeposists;

  String get yardingSelfRelease;

  String get help;

  String get count;

  String get today;

  String get weekly;

  String get monthly;

  String get cheque;

  String get cash;

  String get loanAccountNumber;

  String get receiptDate;

  String get selected;

  String get enterDepositionDetails;

  String get enterRepoDetails;

  String get bank;

  String get companybranch;

  String get branchName;

  String get branchLocation;

  String get receiptAmount;

  String get depositAmount;

  String get yarding;

  String get selfRelease;

  String get yardName;

  String get remark;

  String get uploadDepositSlip;

  String get send;

  String get typeYourMessage;

  String get depositionMode;

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

  String get showOnlyStar;

  String get new_;

  String get overdueAmount;

  String get loanAmount;

  String get loanDuration;

  String get pos;

  String get schemeCode;

  String get emiStartDate;

  String get bankName;

  String get ifscCode;

  String get accNumber;

  String get repoStatus;

  String get repoDate;

  String get repaymentInfo;

  String get beneficiaryDetails;

  String get repaymentBankName;

  String get referenceLender;

  String get referenceUrl;

  String get caseDetials;

  String get sendSms;

  String get sendWhatsapp;

  String get otherLoanOf;

  String get view;

  String get customerMet;

  String get customerNotMet;

  String get invalid;

  String get ptp;

  String get ptpType;

  String get rtp;

  String get dispute;

  String get remainderCb;

  String get collections;

  String get ots;

  String get product;

  String get batchNo;

  String get done;

  String get select;

  String get error;

  String get homeAddress;

  String get markAsHome;

  String get notification;

  String get changeLanguage;

  String get changePassword;

  String get languages;

  String get defaultLanguage;

  String get english;

  String get hindi;

  String get tamil;

  String get kannada;

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

  String get rememberMe;

  String get passwordNotMatch;

  String get choiceOtherLanguages;

  String get declinedCall;

  String get leftMessage;

  String get doorLocked;

  String get entryRestricted;

  String get addNewContact;

  String get repo;

  String get otherFeedBack;

  String get submit;

  String get proceed;

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

  String get refCheque;

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

  String get customerContactType;

  String get serviceProvidersList;

  String get callersId;

  String get customerMetCategory;

  String get connected;

  String get unreachable;

  String get writeYourRemarksHere;

  String get selectAppLanguage;

  String get customerLanguagePreference;

  String get doesNotExist;

  String get incorrectNumber;

  String get numberNotWorking;

  String get notOperational;

  String get lineBusy;

  String get switchOff;

  String get rnr;

  String get outOfNetwork;

  String get disConnecting;

  String get address;

  String get phoneNumber;

  String get letsConnectWithManager;

  String get noAllocation;

  String get noAllocationMessage;

  String get caseView;

  String get stop;

  String get startCalling;

  String get searchErrorMessage;

  String get mobileNumber;

  String get email;

  String get check;

  String get resendOTP;

  String get sendOTP;

  String get submitOTP;

  String get businessLoss;

  String get covidImpacted;

  String get financialReason;

  String get incomeLossInTheFamily;

  String get intention;

  String get jobLoss;

  String get jobUncertaintly;

  String get medicalIssue;

  String get salaryIssue;

  String get noInternetConnection;

  String get mode;

  String get saveNewPassword;

  String get enterNewPassword;

  String get enterConfirmNewPassword;

  String get clear;

  String get contact;

  String get pleaseSelectDropDownValue;

  String get pleaseEnterCurrectUserId;

  String get pleaseSelectOptions;

  String get pleaseSelectPaymentMode;

  String get pleaseUploadDepositSlip;

  String get noCaseAvailble;

  String get shouldBeSelectOneCase;

  String get resetPasswordModelViaOTP;

  String get successfullyUpdated;

  String get eventUpdatedSuccessfully;

  String get successfullySubmitted;

  String get loginViaDifferentUser;

  String get event;

  String get changeSecurePIN;

  String get changeYourSecureDigitPIN;

  String get enterYourSecureFourdDigitPin;

  String get newPin;

  String get save;

  String get secureYourAccountByCreatingAFourDigitPin;

  String get forgotPin;

  String get waitFewSecondsYouGetCallFromAdmin;

  String get pleaseWaitForTheCallIsOngoing;

  String get pleaseSpeakWithCustomer;

  String get doesntGetTheAgentAddress;

  String get autoCallingIsComplete;

  String get pleaseCallAgain;

  String get approved;

  String get pendingApproval;

  String get rejected;

  String get homeAddressNotAvailable;

  String get sendSMS;

  String get uploadFile;

  String get upto5mb;

  String get addMoreContact;

  String get uploadAudioFile;

  String get autoCalling;

  String get callConnectedPleaseWait;

  String get canceled;

  String get uploadImage;

  String get successfullySMSsend;

  String get pleaseWait;

  String get userIDDoesNotExist;

  String get invalidPassword;

  String get notSelectedCase;

  String get pleaseSelectMaximum5MbFile;

  String get pleaseSelectCustomerContactType;

  String get pleaseSelectCorrectPassword;

  String get emailNotAvailable;

  String get invalidAddress;

  String get loading;

  String get reciptsAlertMesg;

  String get sendSMSerror;

  String get logiginDeifferentFailMessage;

  String get logiginDeifferentSucessMessage;

  String get disputeWithCharges;

  String get loanCleared;

  String get dropDownDispute;

  String get edit;

  String get remarksRecording;

  String get chooseLanguage;

  String get selectedLanguage;

  String get errorMsgS2TlangCode;

  String get generatePaymentLink;

  String get showQRcode;

  String get close;

  // Customer Preference Languages
  String get tamilLang;

  String get hindiLang;

  String get bengaliLang;

  String get gujaratiLang;

  String get kannadaLang;

  String get urduLang;

  String get malayalamLang;

  String get marathiLang;

  String get panjabiLang;

  String get teluguLang;

  String get accountPassword;

  String get enterOTP;

  String get otpSentRegisterMobile;

  String get youAreInOffline;

  String get disposition;

  String get visit;

  String get selectSpeechToTextLanguage;

  String get agent;

  String get dateOfLoanDisbursement;

  String get tos;

  String get emiAmount;

  String get noOfPendingEMI;

  String get penaltyAmount;

  String get odInterest;

  String get assetDetails;

  String get coLender;

  String get employerBusinessEntity;

  String get lastPaymentDate;

  String get sourcingRmName;

  String get lastPaidAmount;

  String get riskRanking;

  String get reviewFlag;

  String get location;

  String get agency;

  String get minDueAmount;

  String get cardOutstanding;

  String get statementDate;

  String get dueDate;

  String get cardStatus;

  String get lastBilledAmount;

  String get chassisNumber;

  String get riskBucket;

  String get ref1;

  String get ref2;

  String get loanDetails;

  String get agentDetails;

  String get repaymentInformation;

  String get attributeDetails;

  String get contactDetails;

  String get auditDetails;

  String get primaryUser;

  String get secondaryUser;

  String get agentName;

  String get agentType;

  String get state;

  String get city;

  String get createdBy;

  String get createdAt;

  String get updatedBy;

  String get updatedAt;

  String get allocatedBy;

  String get allocatedAt;

  String get residenceAddress;

  String get mobile;

  String get officeaddress;

  String get followUpPriority;

  String get fatherSpouseName;

  String get lastPaymentMode;

  String get dpd;

  String get zone;

  String get language;

  String get beneficiaryAccountNumber;

  String get chat;

  String get authorizationLetter;

  String get idCard;

  String get front;

  String get back;

  String get notInterested;

  String get notEligible;

  String get login;

  String get feedback;

  String get reasonForNotEligible;

  String get reasonForNotIntrested;

  String get loginStatus;

  String get upload;

  String get enable;
}
