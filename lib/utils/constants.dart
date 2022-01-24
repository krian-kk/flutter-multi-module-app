class Constants {
  static const String inr = '₹ ';
  static const String home = 'home';
  static const String pageNo = '1';
  static const String limit = '5';
  static const String help = 'Help';
  // Type of userType
  static const String fieldagent = 'FIELDAGENT';
  static const String telecaller = 'TELECALLER';

  static const String ptp = 'PTP';
  static const String rtp = 'RTP (DENIAL)';
  static const String denial = 'DENIAL';
  static const String dispute = 'DISPUTE';
  static const String remainder = 'Reminder';
  static const String remainder_1 = 'Reminder';
  static const String collections = 'COLLECTIONS';
  static const String ots = 'OTS';
  static const String otherFeedback = 'OTHER FEEDBACK';
  static const String leftMessage = 'Left Message';
  static const String wrongAddress = 'Wrong Address';
  static const String entryRestricted = 'Entry Restricted';
  static const String repo = 'REPO';
  static const String imageCaptured = 'IMAGE CAPTURED';
  static const String feedBack = 'FEEDBACK';
  static const String shifted = 'Shifted';
  static const String doorLocked = 'Door Locked';
  static const String addressNotFound = 'Address Not Found';
  static const String lineBusy = 'TC : Line Busy';
  static const String switchOff = 'TC : Switch Off';
  static const String rnr = 'TC : RNR';
  static const String outOfNetwork = 'TC : Out Of Network';
  static const String disconnecting = 'TC : Disconnecting';
  static const String doesNotExist = 'TC : Does Not Exist';
  static const String incorrectNumber = 'TC : Incorrect Number';
  static const String notOpeartional = 'TC : Not Operational';
  static const String numberNotWorking = 'TC : Number Not Working';

  // This is used for check telsubstatus
  static const String telsubstatuslineBusy = 'Line Busy';
  static const String telsubstatusswitchOff = 'Switch Off';
  static const String telsubstatusrnr = 'RNR';
  static const String telsubstatusoutOfNetwork = 'Out Of Network';
  static const String telsubstatusdisconnecting = 'Disconnecting';
  static const String telsubstatusdoesNotExist = 'Does Not Exist';
  static const String telsubstatusincorrectNumber = 'Incorrect Number';
  static const String telsubstatusnotOpeartional = 'Not Operational';
  static const String telsubstatusnumberNotWorking = 'Number Not Working';

  static const String addressDetails = 'Address Details';
  static const String callDetails = 'Call Details';
  static const String captureImage = 'CAPTURE IMAGE';
  static const String addNewContact = 'ADD New contact';
  static const String mapView = 'MAP VIEW';
  static const String call = 'CALL';
  static const String viewMap = 'VIEW MAP';
  static const String eventDetails = 'EVENT DETAILS';
  static const String callCustomer = 'CALL CUSTOMER';
  static const String successfullySubmitted = 'Successfully submitted!!';
  static const String eventUpdatedSuccess = 'Event updated successfully.';
  static const String successfullyUpdated = 'Successfully Updated !!';
  static const String resetPassword = 'Reset password via OTP';
  static const String notSelectedCase = 'Should be select one case';
  static const String noCasesAvailable = 'No Case Available';
  static const String uploadDepositSlip = 'Please upload deposit slip';
  static const String pleaseSelectPaymentMode = 'Please Select Payment Mode!';
  static const String pleaseSelectOptions = 'Please Select Options';
  static const String pleaseEnterCorrectUserId = 'Please Enter Currect User ID';
  static const String pleaseSelectDropDownValue =
      'Please Select Drop Down Value';
  static const String success = 'success';
  static const String receipt = 'RECEIPT';

  // My Receipts Tab
  static const String approved = 'Approved';
  static const String pendingApproval = 'Pending Approval';
  static const String rejected = 'Rejected';
  static const int otpWaitingTime = 60;

  static List<int> keyBoardNumberList() {
    final List<int> keyBoardNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    keyBoardNumber.shuffle();
    keyBoardNumber.insert(9, 0);
    keyBoardNumber.insert(11, 0);
    return keyBoardNumber;
  }

  // Remember login field values storage key
  static const String rememberMe = 'remember_me';
  static const String rememberUserId = 'rememberUserId';
  static const String rememberPassword = 'rememberPassword';

  // sharedpreference local storage key
  static const String userType = 'userType';
  static const String userId = 'userId';
  static const String accessToken = 'accessToken';
  static const String accessTokenExpireTime = 'accessTokenExpireTime';
  static const String refreshToken = 'refreshToken';
  static const String refreshTokenExpireTime = 'refreshTokenExpireTime';
  static const String keycloakId = 'keycloakId';
  static const String sessionId = 'sessionId';
  static const String agentRef = 'agentRef';
  static const String agentName = 'agentName';
  static const String mobileNo = 'mobileNo';
  static const String email = 'email';
  static const String contractor = 'contractor';
  static const String status = 'status';
  static const String userAdmin = 'userAdmin';
  static const String code = 'code';
  static const String buildcontext = 'buildcontext';
  static const String callConnectedPleaseWait = 'Call gets connected';
  static const String internalServerError = 'Internal Server Error !!';
  static const String emailNotAvailable =
      'Email ID not available, Mobile number available, send OTP via SMS';
  static const String reciptsAlertMesg =
      'Ensure the collected amount/cheque is deposited in the bank within 24 hours';
  static const String bankReceiptAmountDoesntMatch =
      'There is mismatch in the receipt amount. Do you wish to continue?';
  static const String noOtherLoanAvailable = "No other loan's available.";
  static const String events = 'Events';
  static const String connectionTimeout = 'connection timeout';
}
