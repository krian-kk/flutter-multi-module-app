class ConstantEventValues {
  // this is static for all post events
  static const String voiceCallEventCode = 'TELEVT011';
  static const String dummyHealth = '1';
  //Health values and color showing based on health status
// Cust met, connected -> health 2  -> green
// Cust not met, unreachable -> health 1 -> orange
// Invalid -> health 0 -> red
// No health value or null -> grey or pink
  static const String healthZero = '0';
  static const String healthOne = '1';
  static const String healthTwo = '2';

  // PTP post event
  static const int ptpEventId = 16;
  static const String ptpEventCode = 'TELEVT001';
  static const String ptpType = 'Money';

  // RTP Denial post event
  static const int rtpDenialEventId = 20;
  static const String rtpDenialEventCode = 'TELEVT004';

  // Dispute post event
  static const int disputeEventId = 19;
  static const String disputeEventCode = 'TELEVT005';
}
