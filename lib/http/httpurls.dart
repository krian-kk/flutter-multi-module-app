class HttpUrl {
  static const String baseUrl = 'https://devapi.instalmint.com/';
  static const String version = 'v1/';
  static const String fieldAgent = 'agent/';

  //login
  static const String login_keycloak =
      'http://10.221.10.248:8080/auth/realms/origa-dev/protocol/openid-connect/token';
  static const String loginUrl =
      'https://uat-collect.origa.ai/node/api/user/loginWeb';
  static const String agentDetailUrl =
      'https://uat-collect.origa.ai/node/field-allocation/agents/';

  //Get API
  static const String dashboardUrl =
      baseUrl + version + fieldAgent + 'profile/dashboard?';
  static const String caseDetailsUrl =
      baseUrl + version + fieldAgent + 'case-details/caseDetails?';
  static String eventDetailsUrl({String? caseId, String? usertype}) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/eventDetails?userType=$caseId&caseId=$usertype';

  static const String priorityCaseList =
      baseUrl + version + fieldAgent + 'case-details/priority?';
  static const String buildRouteCaseList =
      baseUrl + version + fieldAgent + 'case-details/buildRoute?';
  static const String profileUrl =
      baseUrl + version + fieldAgent + 'profile/userDetails';

  // Call Customer Post API
  static const String callCustomerUrl =
      baseUrl + version + fieldAgent + 'case-details-events/clickToCall';

  // Mobile Info Post API
  static const String mobileInfoUrl =
      baseUrl + version + fieldAgent + 'profile/mobileInfo';

  // Post API ===================================================
  // Collection Post API
  static String collectionPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Other FeedBack Post API
  static String otherFeedBackPostUrl(
          String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Are You At Office?
  static String areYouAtOfficeUrl() =>
      baseUrl + version + fieldAgent + 'profile/officeCheckIn';
  // Are You At Office?
  static String resetPasswordCheckUrl(String agentName) =>
      'https://uat-collect.origa.ai/node/field-allocation/agents/info/$agentName';
  // baseUrl + version + fieldAgent + '';
  // Reques OTP
  static String requestOTPUrl() =>
      baseUrl + version + fieldAgent + 'profile/requestOtp';
  // Home Address in Profile Screen
  static String homeAddressUrl() =>
      baseUrl + version + fieldAgent + 'profile/homeAddress';
  // Resent OTP Post API
  static String resendOTPUrl() =>
      baseUrl + version + fieldAgent + 'profile/requestOtp';
  // Resent Password Post API
  static String resendPasswordUrl() =>
      baseUrl + version + fieldAgent + 'profile/resetPassword';
  // RTP(Denial) Post API
  static String denialPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Reminder Post API
  static String reminderPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Repo Post API
  static String repoPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Dispute Post API
  static String disputePostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Dispute Post API
  static String ptpPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // Unreachable Post API
  static String unreachableUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // ==================
  // Customer Not Met Post API
  static String leftMessageUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String doorLockedUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String entryRestrictedUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // Address Invalid Post API
  static String wrongAddressUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String shiftedUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String addressNotFoundUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // Phone Invalid Post API
  static String doesNotExistUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String incorrectNumberUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String numberNotWorkingUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String notOperationalUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // DashBoard
  static const String dashboardPriorityFollowUpUrl =
      baseUrl + version + fieldAgent + 'case-details/priorityFollowUp';
  static const String dashboardBrokenPTPUrl =
      baseUrl + version + fieldAgent + 'case-details/brokenPtp';
  static const String dashboardUntouchedCasesUrl =
      baseUrl + version + fieldAgent + 'case-details/untouchedCases';

  static const String dashboardMyVisitsUrl =
      baseUrl + version + fieldAgent + 'case-details/visits?';
  static const String dashboardMyReceiptsUrl =
      baseUrl + version + fieldAgent + 'case-details/receipts?';
  static const String dashboardMyDeposistsUrl =
      baseUrl + version + fieldAgent + 'case-details/deposits?';

  static const String dashboardYardingAndSelfReleaseUrl = baseUrl +
      version +
      fieldAgent +
      'case-details/yardingData?caseId=6181646813c5cf70dea671d2';
  static const String searchUrl =
      baseUrl + version + fieldAgent + 'case-details/search?';
  static const String fileUpload = '';

  //post API

  static const String bankDeposit =
      baseUrl + version + fieldAgent + 'case-details-events/bankDeposition?';

  static const String companyBranchDeposit =
      baseUrl + version + fieldAgent + 'case-details-events/companyDeposition?';

  static const String yarding =
      baseUrl + version + fieldAgent + 'case-details-events/yarding?';

  static const String selfRelease =
      baseUrl + version + fieldAgent + 'case-details-events/selfRelease?';

  static const String changeProfileImage =
      baseUrl + version + fieldAgent + 'profile/profileImgUrl';

  static const String imageCaptured =
      baseUrl + version + fieldAgent + 'case-details-events/imageCaptured?';
}
