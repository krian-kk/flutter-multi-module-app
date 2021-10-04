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

  String get under5Km;

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

  // String get liveSupport;

  // String get complete;

  // String get KYCRequired;

  // String get statement;

  // String get viewFullHistory;

  // String get detailedStatement;

  // String get lastMonth;

  // String get lastThreeMonth;

  // String get lastSixMonth;

  // String get selectCustomDateRange;

  // String get statementDuration;

  // String get startDate;

  // String get endDate;

  // String get downloadStatement;

  // String get downloadPDF;

  // String get downloadStatementOverEmail;

  // String get filter;

  // String get allPaidAndReceived;

  // String get credit;

  // String get debit;

  // String get allUPITransactionStaus;

  // String get failure;

  // String get success;

  // String get timeout;

  // String get allPaymentsTypes;

  // String get editAddress;

  // String get billDetails;

  // String get toPay;

  // String get expressionPocketsCard;

  // String get gst;

  // String get placeOrder;

  // String get thankYou;

  // String get returntoAccountDetails;

  // String get transfers;

  // String get upi;

  // String get billPayment;

  // String get onlinePayment;

  // String get showResults;

  // String get startDateRequired;

  // String get endDateRequired;

  // String get startAndEndDateRequired;

  // String get statementSentMessage;

  // String get statementSentNote;

  // String get done;

  // String get allServices;

  // String get notifications;

  // String get clearAll;

  // String get today;

  // String get yesterday;

  // String get notificationEmpty;

  // String get notificationEmptyDescription;

  // String get trackShipment;

  // String get orderDetails;

  // String get dateOfOrder;

  // String get closed;

  // String get amount;

  // String get amountPaid;

  // String get estimatedDelivery;

  // String get deliveryAddress;

  // String get payment;

  // String get rechargeBillsOffers;

  // String get bank;

  // String get trackServiceRequest;

  // String get openRequest;

  // String get closedRequest;

  // String get serviceRequestNo;

  // String get open;

  // String get description;

  // String get haveMoreQuestions;

  // String get ourSupport;

  // String get gotoSupport;

  // String get noOpenRequestFound;

  // String get trackPhysicalCard;

  // String get nothingyouorderedPhysicalCard;

  // String get requestPhysicalCard;

  // String get upiid;

  // String get checkAvailability;

  // String get alternateSuggestedUpiid;

  // String get notAvailable;

  // String get available;

  // String get pocketStatement;

  // String get accounts;

  // String get others;

  // String get setTransactionLimit;

  // String get reqForWalletClosure;

  // String get authenticateAccount;

  // String get selectBankAccount;

  // String get selectDebitCard;

  // String get gridNumber;

  // String get gridHint;

  // String get gridWrongHint;

  // String get paymentStatus;

  // String get sentTo;

  // String get sentAmountId;

  // String get sentDate;

  // String get transactionId;

  // String get transRefNo;

  // String get transferVia;

  // String get vpa;

  // String get sentFrom;

  // String get remark;

  // String get category;

  // String get outgoingTransfer;

  // String get edit;

  // String get na;

  // String get raiseDispute;

  // String get validFrom;

  // String get validThru;

  // String get validFromDate;

  // String get validToDate;

  // String get viewCvv;

  // String get cvv;

  // String get enterCurrentPasscode;

  // String get enterNewPasscode;

  // String get confirmPasscode;

  // String get passcodeChangedSuccessfully;

  // String get pinCreatedSuccessfully;
  // String get termsAndConditions;
  // String get iHave;
  // String get proceed;
  // String get passcodeChangedSuccessfullySubText;

  // String get notMatchedText;

  // String get changePasscode;

  // String get weDontDeliverHere;

  // String get regularPocketsCard;

  // String get selectAddress;

  // String get deliverTo;

  // String get applyNow;

  // String get continuee;

  // String get changeLocation;

  // String get save;

  // String get addFund;

  // String get addFunds;

  // String get requestForPhysicalCard;

  // String get paidAmount;

  // String get copyToClipboard;

  // String get pocketsRewards;

  // String get pocketsRewardsDes;

  // String get availNow;

  // String get pocketsRewardsDes1;

  // String get expressionPocketCard;

  // String get blockYourPhysicalCard;

  // String get more;

  // String get completeKYC;

  // String get dontShowMeAgain;

  // String get kycComplete;

  // String get kycCompleteDescription;

  // String get viewStatement;
  // String get termsAndConditionsApply;
  // String get welcomeHomeScreen;
  // String get welcomeHomeText;
  // String get welcomeExisting;
  // String get setUpPasscode;
  String get logout;
}
