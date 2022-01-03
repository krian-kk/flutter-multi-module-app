class ConstantEventValues {
  // this is static for all post events
  static const String voiceCallEventCode = 'TELEVT011';
  static const String dummyHealth = '1';

  // PTP post event
  static const int ptpEventId = 16;
  static const String ptpEventCode = 'TELEVT001';
  static const String ptpType = 'Money';

  // RTP Denial post event
  static const int rtpDenialEventId = 20;
  static const String rtpDenialEventCode = 'TELEVT004';

  // Remainder Post Event
  static const int remainderEventId = 19;
  static const String remainderEvenCode = 'TELEVT006';

  // Repo Post Event
  static const int repoEventId = 16;
  static const String repoEvenCode = 'TELEVT016';

  // Collections Post Event
  static const int collectionEventId = 17;
  static const String collectionEvenCode = 'TELEVT003';

  // otherFeedback Post Event
  static const int otherFeedbackEventId = 21;
  static const String otherFeedbackEvenCode = 'TELEVT002';

  // AddressCustomerNotMet Post Event
  static const addressCustomerNotMetEventId = 24;
  static const String addressCustomerNotMetEvenCode = 'TELEVT007';
}
