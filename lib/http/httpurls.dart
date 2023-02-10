class HttpUrl {
  // 1st - Customer will be reject ->
  // static String url = 'https://collect.origa.ai';
  static String url = 'https://uat-collect.origa.ai';
  // static String url = 'https://demo-collect.origa.ai';

  // static String? url = Singleton.instance.baseUrl;
  static const String version = 'v1/';
  static const String apiType = 'app_otc/';
  static const String fieldAgent = 'agent/';
  static String baseUrl = '$url/$apiType$version';

  static final String loginUrl = '$url/node/api/user/loginWeb';
  static final String agentDetailUrl = '$url/node/field-allocation/agents/';

  // Get Agent Secure Pin Code
  static final String agentSecurePinUrl = '$baseUrl/profile/userDetailsAPI';

  // Get agent detail for Reset password screen
  static String resetPasswordCheckUrl(String agentName) =>
      '$url/node/field-allocation/agents/info/$agentName';

  static String sendSMSurl = '$url/node/api/v2/notification/sendNotification';
  static final String chatHistory2 = '$url/node/api/getChatHistory/';

  //Get API
  // For AutoCalling API
  static final String autoCallingURL =
      baseUrl + fieldAgent + 'case-details/priority?forAutocalling=true';

  static final String dashboardUrl =
      baseUrl + fieldAgent + 'profile/dashboard?';
  static final String telDashboardUrl =
      baseUrl + fieldAgent + 'profile/telDashboard?';
  static final String caseDetailsUrl =
      baseUrl + fieldAgent + 'case-details/caseDetails?';
  static final String voiceAgencyDetailsUrl =
      baseUrl + fieldAgent + 'profile/voiceAgencyDetails';
  static final String agentInformation =
      baseUrl + fieldAgent + 'profile/agentDetails?';

  static String eventDetailsUrl({String? caseId, String? userType}) =>
      baseUrl + fieldAgent + 'case-details-events/eventDetails?caseId=$caseId';

  static final String priorityCaseListV2 =
      '$url/$apiType' 'v2/' + fieldAgent + 'case-details/priority?';

  static final String priorityCaseListV1 =
      '$url/$apiType' 'v1/' + fieldAgent + 'case-details/priority?';

  static final String updateStaredCase =
      baseUrl + fieldAgent + 'case-details/update_starredCase';
  static final String buildRouteCaseList =
      baseUrl + fieldAgent + 'case-details/buildRoute?';
  static final String profileUrl = baseUrl + fieldAgent + 'profile/userDetails';
  static final String dashboardEventCountUrl =
      baseUrl + fieldAgent + 'profile/dashEventCount';
  static final String callCustomerUrl =
      baseUrl + fieldAgent + 'case-details-events/clickToCall';
  static final String enableCloudTelephony =
      baseUrl + fieldAgent + 'case-details-events/enableCloudTelephony';
  static final String mobileInfoUrl =
      baseUrl + fieldAgent + 'profile/mobileInfo';

  // Collection Post API
  static String collectionPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static final String otsPostUrl =
      baseUrl + fieldAgent + 'case-details-events/ots';

  // Other FeedBack Post API
  static String otherFeedBackPostUrl(
          String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // Contractor detail api for FeedBack page
  static String contractorDetail =
      baseUrl + fieldAgent + 'case-details-events/contractorDetails';

  // Are You At Office?
  static String areYouAtOfficeUrl() =>
      baseUrl + fieldAgent + 'profile/officeCheckIn';

  // baseUrl  + fieldAgent + '';
  static String requestOTPUrl() => '$url/$apiType' 'public/requestOtp';

  static String homeAddressUrl() =>
      baseUrl + fieldAgent + 'profile/homeAddress';

  static String resendOTPUrl() => '$url/${apiType}public/requestOtp';

  static String resetPasswordUrl() => '$url/${apiType}public/resetPassword';

  static String verifyOTP() => '$url/${apiType}public/verifyOtp';

  static final String createMpin = '$baseUrl${fieldAgent}profile/updateMPIN';

  static String denialPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String reminderPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String repoPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String disputePostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String ptpPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String unreachableUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String leftMessageUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String doorLockedUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String entryRestrictedUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String wrongAddressUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String shiftedUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String addressNotFoundUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String doesNotExistUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String incorrectNumberUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String numberNotWorkingUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  static String notOperationalUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // For call Get Status
  static final String callCustomerStatusGetUrl =
      baseUrl + fieldAgent + 'case-details-events/getCallStatus';

  // DashBoard
  static final String dashboardPriorityFollowUpUrl =
      baseUrl + fieldAgent + 'case-details/priorityFollowUp';
  static final String dashboardBrokenPTPUrl =
      baseUrl + fieldAgent + 'case-details/brokenPtp';
  static final String dashboardUntouchedCasesUrl =
      baseUrl + fieldAgent + 'case-details/untouchedCases';

  static final String dashboardMyVisitsUrl =
      baseUrl + fieldAgent + 'case-details/visits?';
  static final String dashboardMyCallsUrl =
      baseUrl + fieldAgent + 'case-details/myCalls?';
  static final String dashboardMyReceiptsUrl =
      baseUrl + fieldAgent + 'case-details/receipts?';
  static final String dashboardMyDeposistsUrl =
      baseUrl + fieldAgent + 'case-details/deposits?';

  static final String dashboardYardingAndSelfReleaseUrl =
      baseUrl + fieldAgent + 'case-details/yardingData';
  static final String searchUrl = baseUrl + fieldAgent + 'case-details/search?';

  // static const String fileUpload = '';

  //post API

  static final String bankDeposit =
      baseUrl + fieldAgent + 'case-details-events/bankDeposition?';

  static final String companyBranchDeposit =
      baseUrl + fieldAgent + 'case-details-events/companyDeposition?';

  static final String yarding =
      baseUrl + fieldAgent + 'case-details-events/yarding?';

  static final String selfRelease =
      baseUrl + fieldAgent + 'case-details-events/selfRelease?';

  static final String changeProfileImage =
      baseUrl + fieldAgent + 'profile/profileImgUrl';

  static final String imageCaptured =
      baseUrl + fieldAgent + 'case-details-events/imageCaptured?';

  // chat token request
  static final String chatTokenRequest = baseUrl + 'chat/tokenRequest';

  static final String chatHistory = baseUrl + 'chat/history';

  // Convert Voice to Text Post API
  static final String audioRemarksURL =
      baseUrl + fieldAgent + 'case-details-events/audioRemarks_upload';

  // Get audio file from API
  static final String getAudioFile =
      baseUrl + fieldAgent + 'case-details-events/get_audioFile';

  // Get Payment Configuration Detail
  static final String getPaymentConfiguration =
      baseUrl + 'payment/getPaymentConfigurations';

  // Generate Dyanamic Payment Link & QR
  static final String generateDyanamicPaymentLink =
      baseUrl + 'payment/generateDyanamicPaymentLink';

//Send Whatsapp message from backend
  static final String sendWhatsapp =
      baseUrl + fieldAgent + 'case-details/notifyCustomer?';

  //Send Whatsapp button showing based on whatsapp api key
  static final String campaignConfig =
      baseUrl + fieldAgent + 'case-details-events/campaignConfig';

  //chat count update
  static final String updateChatSeen = '$url/node/api/updateFCMMessage';

  static final String authorizationLetter =
      baseUrl + fieldAgent + 'profile/getAuthorizationLetter';

  static final String idCardFront =
      baseUrl + fieldAgent + 'profile/getIdCardFront';

  static final String idCardBack =
      baseUrl + fieldAgent + 'profile/getIdCardBack';
  // Get Agent Secure Pin Code
  static final String updateDeviceLocation =
      baseUrl + fieldAgent + 'profile/updateDeviceLocation?';

  static final String notEligible =
      baseUrl + fieldAgent + 'case-details-events/notEligible';

  static final String notInterested =
      baseUrl + fieldAgent + 'case-details-events/notInterested';

  static final String loginEvent =
      baseUrl + fieldAgent + 'case-details-events/login';
}
