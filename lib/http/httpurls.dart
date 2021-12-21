class HttpUrl {
  static const String baseUrl = 'https://uat-collect.origa.ai/app_otc/';
  // static const String baseUrl = 'https://devapi.instalmint.com/';
  static const String version = 'v1/';
  static const String fieldAgent = 'agent/';

  //login
  // static const String login_keycloak =
  //     'http://10.221.10.248:8080/auth/realms/origa-dev/protocol/openid-connect/token';
  static const String loginUrl =
      'https://uat-collect.origa.ai/node/api/user/loginWeb';
  static const String agentDetailUrl =
      'https://uat-collect.origa.ai/node/field-allocation/agents/';

  //Get API
  static const String dashboardUrl =
      baseUrl + version + fieldAgent + 'profile/dashboard?';
  static const String caseDetailsUrl =
      baseUrl + version + fieldAgent + 'case-details/caseDetails?';
  static const String voiceAgencyDetailsUrl =
      baseUrl + version + fieldAgent + 'profile/voiceAgencyDetails';
  static String eventDetailsUrl({String? caseId, String? userType}) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/eventDetails?caseId=$caseId';
  static const String priorityCaseList =
      baseUrl + version + fieldAgent + 'case-details/priority?';
  static const String buildRouteCaseList =
      baseUrl + version + fieldAgent + 'case-details/buildRoute?';
  static const String profileUrl =
      baseUrl + version + fieldAgent + 'profile/userDetails';
  static const String callCustomerUrl =
      baseUrl + version + fieldAgent + 'case-details-events/clickToCall';
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
  static String requestOTPUrl() =>
      baseUrl + version + fieldAgent + 'profile/requestOtp';
  static String homeAddressUrl() =>
      baseUrl + version + fieldAgent + 'profile/homeAddress';
  static String resendOTPUrl() =>
      baseUrl + version + fieldAgent + 'profile/requestOtp';
  static String resendPasswordUrl() =>
      baseUrl + version + fieldAgent + 'profile/resetPassword';
  static String denialPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String reminderPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String repoPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String disputePostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String ptpPostUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
  static String unreachableUrl(String selectValue, String userTypeValue) =>
      baseUrl +
      version +
      fieldAgent +
      'case-details-events/$selectValue?userType=$userTypeValue';
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

  static const String dashboardYardingAndSelfReleaseUrl =
      baseUrl + version + fieldAgent + 'case-details/yardingData';
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
