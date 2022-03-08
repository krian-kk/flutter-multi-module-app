class ConstantEventValues {
  // this is static for all post events
  static const String voiceCallEventCode = 'TELEVT011';
  // static const String dummyHealth = '1';
  //Health values and color showing based on health status
// Cust met, connected -> health 2  -> green
// Cust not met, unreachable -> health 1 -> orange
// Invalid -> health 0 -> red
// No health value or null -> grey or pink
  static const String healthZero = '0';
  static const String healthOne = '1';
  static const String healthTwo = '2';
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

  // Dispute post event
  static const int disputeEventId = 19;
  static const String disputeEventCode = 'TELEVT005';
  static const String disputeHealth = '2';

  // Remainder Post Event
  static const int remainderEventId = 19;
  static const String remainderEvenCode = 'TELEVT006';
  static const String remainderHealth = '2';

  // Repo Post Event
  static const int repoEventId = 16;
  static const String repoEvenCode = 'TELEVT016';

  // Collections Post Event
  static const int collectionEventId = 17;
  static const String collectionEvenCode = 'TELEVT003';
  static const String collectionHealth = '2';

  // otherFeedback Post Event
  static const int otherFeedbackEventId = 21;
  static const String otherFeedbackEvenCode = 'TELEVT002';

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
  static const String rnrEvenCode = 'TELEVT007';
  static const String outOfNetworkEvenCode = 'TELEVT007';
  static const String disConnectingEvenCode = 'TELEVT007';

  // PhoneInvalid Post Event
  static const int phoneInvalidEventId = 24;
  static const String phoneInvalidEvenCode = 'TELEVT008';
  static const String phoneInvalidHealth = '0';

  // CaptureImage Post Event
  static const int captureImageEventId = 22;
  static const String captureImageEvenCode = 'TELEVT015';
  // static const String captureImageHealth = '2';

  // Are You At Office
  static const int areYouAtOfficeEventId = 16;
  static const String areYouAtOfficeEvenCode = 'TELEVT017';

  // OTS Post Event
  static const int otsEventId = 25;
  static const String otsEvenCode = 'EVT02';
  static const String otsHealth = '2';
}
