class Constants {
  static const String inr = '₹ ';
  static const String home = 'home';
  static const String pageNo = '1';
  static const String limit = '10';
  static const String ptp = 'PTP';
  static const String rtp = 'RTP (DENIAL)';
  static const String denial = 'DENIAL';
  static const String dispute = 'DISPUTE';
  static const String remainder = 'REMINDER';
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

  static const String addressDetails = 'Address Details';
  static const String callDetails = 'Call Details';
  static const String captureImage = 'CAPTURE IMAGE';
  static const String addNewContact = 'ADD New contact';
  static const String call = 'CALL';
  static const String viewMap = 'VIEW MAP';
  static const String eventDetails = 'EVENT DETAILS';
  static const String callCustomer = 'CALL CUSTOMER';
  static const String successfullySubmitted = 'Successfully submitted!!';
  static const String resetPassword = 'Reset password via OTP';
  static const String notSelectedCase = 'Should be select one loan';
  static const String noCasesAvailable = 'No Case Available';
  static const String uploadDepositSlip = 'Please upload deposit slip';
  static const String pleaseSelectPaymentMode = 'Please Select Payment Mode!';
  static const String pleaseSelectOptions = 'Please Select Options';
  static const String pleaseSelectDropDownValue =
      'Please Select Drop Down Value';
  static const String success = 'success';
  static const int otpWaitingTime = 60;

  static List<int> keyBoardNumberList() {
    final List<int> keyBoardNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    keyBoardNumber.shuffle();
    keyBoardNumber.insert(9, 0);
    keyBoardNumber.insert(11, 0);
    return keyBoardNumber;
  }
}
