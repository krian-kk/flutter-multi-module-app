import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get labelWelcome;

  String get labelSelectLanguage;

  String get showPopUp;

  String get setLightTheme;

  String get setDarkTheme;

  String get noteWalletSuccess;

  String get walletUPIid;

  String get orderStatus;

  String get walletLimit;

  String get virtualVISAcard;

  String get congratulations;

  String get goToDashboard;

  String get welcomeString;

  String get pockets;

  String get welcomeDescriptionString;

  String get verifyMobileNumber;

  String get verifyPersonalDetails;

  String get setupPasscode;

  String get verifyYourMobileNumber;

  String get noteWelcomeScreen;

  String get moSimCardErrorMessage;

  String get selectYourSim;

  String get sim;

  String get verify;

  String get noteWelocomeScreen;

  String get exisitingUserRegisterMessage;

  String get numberVerificationString;

  String get numberVerificationDescriptionString;

  String get asPerPanCard;

  String get personalDetails;

  String get dateOfBirth;

  String get male;

  String get female;

  String get transGender;

  String get personalDetailsReq;

  String get personalDetailsDes;

  String get continueText;

  String get ok;

  String get dontAllow;

  String get smsSendDescription;

  String get smsSendDescriptionNote;

  String get mobileNumber;

  String get goodToSeeYouBack;

  String get home;

  String get rewards;

  String get updateAddress;

  String get addAddress;

  String get verifyEmail;

  String get updateEmail;

  String get otpVerification;
  String get set4DigitPIN;
  String get thisPasscode;
  String get enter4DigitPIN;
  String get reEnter4DigitPIN;

  String get otpVerificationDescription;

  String get camera;

  String get gallery;

  String get whatWentWrong;

  String get requestForCallBack;

  String get weHappy;

  String get youCan;

  String get orTap;

  String get someone;

  String get continueToDelete;

  String get requestAccepted;

  String get toDeactivate;

  String get weHaveAccepted;

  String get gotIt;

  String get pleaseTellUs;

  String get reasonForWalletClosure;

  String get closeWallet;

  String get reason;

  String get yourRequest;

  String get referenceNo;

  String get pleaseNote;

  String get weFound;

  String get weSuggest;

  String get trendingService;

  String get reasonforWalletClosure;

  String get seeAllServices;

  String get needHelp;

  String get supportingHours;

  String get liveSupport;

  String get complete;

  String get KYCRequired;

  String get statement;

  String get viewFullHistory;

  String get detailedStatement;

  String get lastMonth;

  String get lastThreeMonth;

  String get lastSixMonth;

  String get selectCustomDateRange;

  String get statementDuration;

  String get startDate;

  String get endDate;

  String get downloadStatement;

  String get downloadPDF;

  String get downloadStatementOverEmail;

  String get filter;

  String get allPaidAndReceived;

  String get credit;

  String get debit;

  String get allUPITransactionStaus;

  String get failure;

  String get success;

  String get timeout;

  String get allPaymentsTypes;

  String get editAddress;

  String get billDetails;

  String get toPay;

  String get expressionPocketsCard;

  String get gst;

  String get placeOrder;

  String get thankYou;

  String get returntoAccountDetails;

  String get transfers;

  String get upi;

  String get billPayment;

  String get onlinePayment;

  String get showResults;

  String get startDateRequired;

  String get endDateRequired;

  String get startAndEndDateRequired;

  String get statementSentMessage;

  String get statementSentNote;

  String get done;

  String get allServices;

  String get notifications;

  String get clearAll;

  String get today;

  String get yesterday;

  String get notificationEmpty;

  String get notificationEmptyDescription;

  String get trackShipment;

  String get orderDetails;

  String get dateOfOrder;

  String get closed;

  String get amount;

  String get amountPaid;

  String get estimatedDelivery;

  String get deliveryAddress;

  String get payment;

  String get rechargeBillsOffers;

  String get bank;

  String get trackServiceRequest;

  String get openRequest;

  String get closedRequest;

  String get serviceRequestNo;

  String get open;

  String get description;

  String get haveMoreQuestions;

  String get ourSupport;

  String get gotoSupport;

  String get noOpenRequestFound;

  String get trackPhysicalCard;

  String get nothingyouorderedPhysicalCard;

  String get requestPhysicalCard;

  String get upiid;

  String get checkAvailability;

  String get alternateSuggestedUpiid;

  String get notAvailable;

  String get available;

  String get pocketStatement;

  String get accounts;

  String get others;

  String get setTransactionLimit;

  String get reqForWalletClosure;

  String get authenticateAccount;

  String get selectBankAccount;

  String get selectDebitCard;

  String get gridNumber;

  String get gridHint;

  String get gridWrongHint;

  String get paymentStatus;

  String get sentTo;

  String get sentAmountId;

  String get sentDate;

  String get transactionId;

  String get transRefNo;

  String get transferVia;

  String get vpa;

  String get sentFrom;

  String get remark;

  String get category;

  String get outgoingTransfer;

  String get edit;

  String get na;

  String get raiseDispute;

  String get validFrom;

  String get validThru;

  String get validFromDate;

  String get validToDate;

  String get viewCvv;

  String get cvv;

  String get enterCurrentPasscode;

  String get enterNewPasscode;

  String get confirmPasscode;

  String get passcodeChangedSuccessfully;

  String get pinCreatedSuccessfully;
  String get termsAndConditions;
  String get iHave;
  String get proceed;
  String get passcodeChangedSuccessfullySubText;

  String get notMatchedText;

  String get changePasscode;

  String get weDontDeliverHere;

  String get regularPocketsCard;

  String get selectAddress;

  String get deliverTo;

  String get applyNow;

  String get continuee;

  String get changeLocation;

  String get save;

  String get addFund;

  String get addFunds;

  String get requestForPhysicalCard;

  String get paidAmount;

  String get copyToClipboard;

  String get pocketsRewards;

  String get pocketsRewardsDes;

  String get availNow;

  String get pocketsRewardsDes1;


  String get expressionPocketCard;

  String get blockYourPhysicalCard;

  String get more;

  String get completeKYC;

  String get dontShowMeAgain;

  String get kycComplete;

  String get kycCompleteDescription;

  String get viewStatement;
  String get termsAndConditionsApply;
  String get welcomeHomeScreen;
  String get welcomeHomeText;
  String get welcomeExisting;
  String get setUpPasscode;
}
