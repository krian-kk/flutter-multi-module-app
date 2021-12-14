class HttpUrl {
  static const String baseUrl = 'https://devapi.instalmint.com/';
  static const String version = 'v1/';
  static const String fieldAgent = 'agent/';

  //Get API
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
  // Reques OTP
  static String requestOTPUrl() =>
      baseUrl + version + fieldAgent + 'profile/requestOtp';
  // Home Address in Profile Screen
  static String homeAddressUrl() =>
      baseUrl + version + fieldAgent + 'profile/homeAddress';
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
      'case-details/yardingData?caseId=5f80375a86527c46deba2e60';
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
