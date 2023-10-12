import 'package:flutter/material.dart';

class CheckWhatsappButtonEnable {
  static bool checkWAbutton(
      {required String? whatsappTemplate,
      required String? whatsappTemplateName,
      required String? whatsappKey}) {
    // debugPrint(
    //     'CheckWhatsappButtonEnable ---->   $whatsappTemplateName $whatsappKey $whatsappTemplate ');
    bool returnValue;
    if (whatsappTemplate == null ||
        whatsappTemplateName == null ||
        whatsappKey == null) {
      returnValue = false;
    } else if (whatsappTemplate == '' ||
        whatsappTemplateName == '' ||
        whatsappKey == '') {
      returnValue = false;
    } else {
      returnValue = true;
    }
    return returnValue;
  }
}
