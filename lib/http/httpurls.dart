class HttpUrl {
  static const String baseUrl = 'https://devapi.instalmint.com/';
  static const String version = 'v1/';
  static const String userType = 'agent/';
  static const String caseDetailsUrl =
      baseUrl + version + userType + 'case-details/caseDetails?caseId=';
  static String eventDetailsUrl(String caseId, String userType) =>
      baseUrl +
      version +
      userType +
      'case-details/eventDetails?caseId=$caseId&userType=$userType';
  static const String priorityCaseList =
      baseUrl + version + userType + 'case-details/priority?pageNo=1&limit=10';
  static const String buildRouteCaseList =
      baseUrl + version + userType + 'case-details/buildRoute?';
  static const String buildRouteUrl = baseUrl +
      version +
      userType +
      'case-details/buildRoute?lat=18.5165691&lng=73.8036752&maxDistMeters=';
  static const String profileUrl = baseUrl +
      version +
      userType +
      'case-details/userDetails?aRef=yes_superadmin&name=yes_superadmin&defMobileNumber=';
  static const String users = baseUrl + 'users/';
  // static const String masterLookUp =
  //     baseUrl + 'ms-communication/lookup/index/mastLookupType/';

  // Post API ===================================================
  // Collection Post API
  static String collectionPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Other FeedBack Post API
  static String otherFeedBackPostUrl(
          String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // RTP(Denial) Post API
  static String denialPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Reminder Post API
  static String reminderPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Repo Post API
  static String repoPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Dispute Post API
  static String disputePostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';
  // Dispute Post API
  static String ptpPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // Unreachable Post API
  static String unreachableUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      userType +
      'case-details-events/$selectValue?userType=$userTypeValue';

  // DashBoard
  static const String dashboardPriorityFollowUpUrl =
      baseUrl + version + userType + 'case-details/priorityFollowUp';
  static const String dashboardBrokenPTPUrl =
      baseUrl + version + userType + 'case-details/brokenPtp';
  static const String dashboardUntouchedCasesUrl =
      baseUrl + version + userType + 'case-details/untouchedCases';
  static const String dashboardMyVisitsUrl =
      baseUrl + version + userType + 'case-details/visits?';
  static const String dashboardMyReceiptsUrl =
      baseUrl + version + userType + 'case-details/receipts?';
  static const String dashboardMyDeposistsUrl =
      baseUrl + version + userType + 'case-details/deposits?';
  static const String dashboardYardingAndSelfReleaseUrl = baseUrl +
      version +
      userType +
      'case-details/yardingData?caseId=5f80375a86527c46deba2e60';
  static const String searchUrl =
      baseUrl + version + userType + 'case-details/search?';
  static const String login = users + 'auth/signin';
  static const String register = users + 'auth/signup';
  static const String otpValidate = users + 'auth/validateOTP';
  static const String getUserProfile = users + 'userprofile';
  // static const String getCountryCodes = masterLookUp + 'AVL';
  static const String editUserProfile = users + 'editprofile';
  static const String deleteUserProfile = users + 'deleteprofile';
  static const String fileUpload = users + 'fileupload';
}
