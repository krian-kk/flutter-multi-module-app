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
      'case-details/eventDetails?caseId=$caseId&userType=$usertype';
  static const String priorityCaseList =
      baseUrl + version + fieldAgent + 'case-details/priority?pageNo=1&limit=10';
  static const String buildRouteCaseList =
      baseUrl + version + fieldAgent + 'case-details/buildRoute?';
  static const String profileUrl = baseUrl +
      version +
      fieldAgent +
      'case-details/userDetails?aRef=yes_superadmin&name=yes_superadmin&defMobileNumber=';

  // DashBoard
  static const String dashboardPriorityFollowUpUrl =
      baseUrl + version + fieldAgent + 'case-details/priorityFollowUp';
  static const String dashboardBrokenPTPUrl =
      baseUrl + version + fieldAgent + 'case-details/brokenPtp';
  static const String dashboardUntouchedCasesUrl =
      baseUrl + version + fieldAgent + 'case-details/untouchedCases';
  static const String dashboardMyVisitsUrl = baseUrl +
      version +
      fieldAgent +
      'case-details/visits?';
  static const String dashboardMyReceiptsUrl =
      baseUrl + version + fieldAgent + 'case-details/receipts?';
  static const String dashboardMyDeposistsUrl =
      baseUrl + version + fieldAgent + 'case-details/deposits?';
  static const String dashboardYardingAndSelfReleaseUrl =
      baseUrl + version + fieldAgent + 'case-details/yardingData?';
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
      baseUrl + version + fieldAgent + 'profile/profileImgUrl?';  

  static const String imageCaptured =
      baseUrl + version + fieldAgent + 'case-details-events/imageCaptured?';  
}
