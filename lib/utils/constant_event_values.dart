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
  static const String rtpDenialEventCode = 'TELEVT001';
  static const String rtpDenialType = 'Money';
}
