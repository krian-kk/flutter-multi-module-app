class Constants {
  static const String inr = '₹ ';
  static const String bioMetricLogin = 'BioMetricLogin';
static const String tenant = 'RBLPENCILTON';
  static const String mpin = 'mpin';

  static const String home = 'home';
  static const String bag = 'bag';
  static const String profileImageShared = 'profileImageShared';
  static const String clearAll = 'clearAll';
  static const String getTrack = 'getTrack';
  static const String getGenerate = 'getTrack';
  static const String kycDontAskMeAgain = 'kycDontAskMeAgain';

  static List<int> keyBoardNumberList() {
    final List<int> keyBoardNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    keyBoardNumber.shuffle();
    keyBoardNumber.insert(9, 0);
    keyBoardNumber.insert(11, 0);
    return keyBoardNumber;
  }
}
