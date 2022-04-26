import 'package:flutter/cupertino.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/constants.dart';

class ConvertString {
  static String convertLanguageToConstant(String text, BuildContext context) {
    String constantValue = text;
    if (text == Languages.of(context)!.lineBusy) {
      constantValue = Constants.telsubstatuslineBusy;
    } else if (text == Languages.of(context)!.switchOff) {
      constantValue = Constants.telsubstatusswitchOff;
    } else if (text == Languages.of(context)!.rnr) {
      constantValue = Constants.telsubstatusrnr;
    } else if (text == Languages.of(context)!.outOfNetwork) {
      constantValue = Constants.telsubstatusoutOfNetwork;
    } else if (text == Languages.of(context)!.disConnecting) {
      constantValue = Constants.telsubstatusdisconnecting;
    } else if (text == Languages.of(context)!.leftMessage) {
      constantValue = Constants.leftMessage;
    } else if (text == Languages.of(context)!.doorLocked) {
      constantValue = Constants.doorLocked;
    } else if (text == Languages.of(context)!.entryRestricted) {
      constantValue = Constants.entryRestricted;
    } else if (text == Languages.of(context)!.doesNotExist) {
      constantValue = Constants.telsubstatusdoesNotExist;
    } else if (text == Languages.of(context)!.incorrectNumber) {
      constantValue = Constants.telsubstatusincorrectNumber;
    } else if (text == Languages.of(context)!.notOperational) {
      constantValue = Constants.telsubstatusnotOpeartional;
    } else if (text == Languages.of(context)!.numberNotWorking) {
      constantValue = Constants.telsubstatusnumberNotWorking;
    } else if (text == Languages.of(context)!.wrongAddress) {
      constantValue = Constants.wrongAddress;
    } else if (text == Languages.of(context)!.shifted) {
      constantValue = Constants.shifted;
    } else if (text == Languages.of(context)!.addressNotFound) {
      constantValue = Constants.addressNotFound;
    } else if (text == Languages.of(context)!.cheque) {
      constantValue = Constants.cheque;
    } else if (text == Languages.of(context)!.selfPay) {
      constantValue = Constants.selfPay;
    } else if (text == Languages.of(context)!.cash) {
      constantValue = Constants.cash;
    } else if (text == Languages.of(context)!.digital) {
      constantValue = Constants.digital;
    } else if (text == Languages.of(context)!.pickUp) {
      constantValue = Constants.pickUp;
    }
    return constantValue;
  }
}
