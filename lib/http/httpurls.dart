class HttpUrl {
  static const String baseUrl = 'https://devapi.instalmint.com/';
  static const String version = 'v1/';
  static const String userType = 'agent/';
  static const String caseDetailsUrl =
      baseUrl + version + userType + 'case-details/caseDetails?caseId=';
  static const String eventDetailsUrl =
      baseUrl + version + userType + 'case-details/eventDetails?caseId=';
  static const String priorityCaseList =
      baseUrl + version + userType + 'case-details/priority?pageNo=1&limit=10';
  static const String buildRouteUrl = baseUrl +
      version +
      userType +
      'case-details/buildRoute?lat=18.5165691&lng=73.8036752&maxDistMeters=';
  static const String profileUrl = baseUrl +
      version +
      userType +
      'case-details/userDetails?aRef=yes_superadmin&name=yes_superadmin&defMobileNumber=';
  static const String users = baseUrl + 'users/';
  static const String masterLookUp =
      baseUrl + 'ms-communication/lookup/index/mastLookupType/';

  // DashBoard
  static const String dashboardPriorityProirityFollowUpUrl =
      baseUrl + version + userType + 'case-details/priorityFollowUp?pincode=';
  static const String dashboardBrokenPTPUrl =
      baseUrl + version + userType + 'case-details/brokenPtp';
  static const String dashboardUntouchedCasesUrl =
      baseUrl + version + userType + 'case-details/untouchedCases';
  static const String dashboardMyVisitsUrl = baseUrl +
      version +
      userType +
      'case-details/visits?timePeriod=WEEKLY&eventType=';
  static const String dashboardMyReceiptsUrl =
      baseUrl + version + userType + 'case-details/receipts?timePeriod=';
  static const String dashboardMyDeposistsUrl =
      baseUrl + version + userType + 'case-details/deposits?timePeriod=';
  static const String dashboardYardingAndSelfReleaseUrl =
      baseUrl + version + userType + 'case-details/yardingData?caseId=';
  static const String searchUrl = baseUrl +
      version +
      userType +
      'case-details/search?starredOnly=true&accNo=';
  static const String login = users + 'auth/signin';
  static const String register = users + 'auth/signup';
  static const String otpValidate = users + 'auth/validateOTP';
  static const String getUserProfile = users + 'userprofile';
  static const String getCountryCodes = masterLookUp + 'AVL';
  static const String editUserProfile = users + 'editprofile';
  static const String deleteUserProfile = users + 'deleteprofile';
  static const String fileUpload = users + 'fileupload';
}
