class Constants {
  static const String inr = '₹ ';
  static const String home = 'home';
  static const String pageNo = '1';
  static const String limit = '10';

  static List<int> keyBoardNumberList() {
    final List<int> keyBoardNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    keyBoardNumber.shuffle();
    keyBoardNumber.insert(9, 0);
    keyBoardNumber.insert(11, 0);
    return keyBoardNumber;
  }
}
