import 'package:flutter/cupertino.dart';
import 'package:languages/language_english.dart';
import 'package:origa/utils/constants.dart';

class ConvertString {
  static String convertLanguageToConstant(String text, BuildContext context) {
    String constantValue = text;
    if (text == LanguageEn().lineBusy) {
      constantValue = Constants.telsubstatuslineBusy;
    } else if (text == LanguageEn().switchOff) {
      constantValue = Constants.telsubstatusswitchOff;
    } else if (text == LanguageEn().rnr) {
      constantValue = Constants.telsubstatusrnr;
    } else if (text == LanguageEn().outOfNetwork) {
      constantValue = Constants.telsubstatusoutOfNetwork;
    } else if (text == LanguageEn().disConnecting) {
      constantValue = Constants.telsubstatusdisconnecting;
    } else if (text == LanguageEn().leftMessage) {
      constantValue = Constants.leftMessage;
    } else if (text == LanguageEn().doorLocked) {
      constantValue = Constants.doorLocked;
    } else if (text == LanguageEn().entryRestricted) {
      constantValue = Constants.entryRestricted;
    } else if (text == LanguageEn().doesNotExist) {
      constantValue = Constants.telsubstatusdoesNotExist;
    } else if (text == LanguageEn().incorrectNumber) {
      constantValue = Constants.telsubstatusincorrectNumber;
    } else if (text == LanguageEn().notOperational) {
      constantValue = Constants.telsubstatusnotOpeartional;
    } else if (text == LanguageEn().numberNotWorking) {
      constantValue = Constants.telsubstatusnumberNotWorking;
    } else if (text == LanguageEn().wrongAddress) {
      constantValue = Constants.wrongAddress;
    } else if (text == LanguageEn().shifted) {
      constantValue = Constants.shifted;
    } else if (text == LanguageEn().addressNotFound) {
      constantValue = Constants.addressNotFound;
    } else if (text == LanguageEn().cheque) {
      constantValue = Constants.cheque;
    } else if (text == LanguageEn().selfPay) {
      constantValue = Constants.selfPay;
    } else if (text == LanguageEn().cash) {
      constantValue = Constants.cash;
    } else if (text == LanguageEn().digital) {
      constantValue = Constants.digital;
    } else if (text == LanguageEn().pickUp) {
      constantValue = Constants.pickUp;
    }
    return constantValue;
  }
}
