class HttpUrl {
  static const String baseUrl = 'https://devapi.instalmint.com/';
  static const String version = 'v1/';
  static const String userType = 'agent/';
  static const String caseDetailsUrl =
      baseUrl + version +userType+'case-details/caseDetails?caseId=';
  static const String priorityCaseList =
      baseUrl + version +userType+'case-details/priority?pageNo=1&limit=10';

  static const String users = baseUrl + 'users/';
  static const String masterLookUp = baseUrl + 'ms-communication/lookup/index/mastLookupType/';
  static const String login = users + 'auth/signin';
  static const String register = users + 'auth/signup';
  static const String otpValidate = users + 'auth/validateOTP';
  static const String getUserProfile = users + 'userprofile';
  static const String getCountryCodes = masterLookUp + 'AVL';
  static const String editUserProfile = users + 'editprofile';
  static const String deleteUserProfile = users + 'deleteprofile';
  static const String fileUpload = users + 'fileupload';
}
