class ConstantEventValues {
  // this is static for all post events
  static const String voiceCallEventCode = 'TELEVT011';
  // static const String dummyHealth = '1';

  // PTP post event
  static const int ptpEventId = 16;
  static const String ptpEventCode = 'TELEVT001';
  static const String ptpType = 'Money';
  static const String ptpHealth = '2';

  // RTP Denial post event
  static const int rtpDenialEventId = 20;
  static const String rtpDenialEventCode = 'TELEVT004';
  static const String rtpDenialHealth = '2';

  // Remainder Post Event
  static const int remainderEventId = 19;
  static const String remainderEvenCode = 'TELEVT006';
  static const String remainderHealth = '2';

  // Repo Post Event
  static const int repoEventId = 16;
  static const String repoEvenCode = 'TELEVT016';
  static const String repoHealth = '2';

  // Collections Post Event
  static const int collectionEventId = 17;
  static const String collectionEvenCode = 'TELEVT003';
  static const String collectionHealth = '2';

  // otherFeedback Post Event
  static const int otherFeedbackEventId = 21;
  static const String otherFeedbackEvenCode = 'TELEVT002';
  static const String otherFeedbackHealth = '2';

  // AddressCustomerNotMet Post Event
  static const int addressCustomerNotMetEventId = 24;
  static const String addressCustomerNotMetEvenCode = 'TELEVT007';
  static const String addressCustomerNotMetHealth = '1';

  // AddressInvalid Post Event
  static const int addressInvalidEventId = 24;
  static const String addressInvalidEvenCode = 'TELEVT008';
  static const String addressInvalidHealth = '0';

  // phoneUnreachable Post Event
  static const int phoneUnreachableEventId = 24;
  static const String phoneUnreachableHealth = '1';
  static const String lineBusyEvenCode = 'TELEVT007';
  static const String switchOffEvenCode = 'TELEVT007';
  static const String rnrEvenCode = 'TELEVT011';
  static const String outOfNetworkEvenCode = 'TELEVT007';
  static const String disConnectingEvenCode = 'TELEVT011';

  // PhoneInvalid Post Event
  static const int phoneInvalidEventId = 24;
  static const String phoneInvalidEvenCode = 'TELEVT008';
  static const String phoneInvalidHealth = '0';

  // CaptureImage Post Event
  static const int captureImageEventId = 22;
  static const String captureImageEvenCode = 'TELEVT015';
  static const String captureImageHealth = '2';
}
