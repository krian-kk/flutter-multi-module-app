class CheckWhatsappButtonEnable {
  static bool checkWAbutton(
      {required String? whatsappTemplate,
      required String? whatsappTemplateName,
      required String? whatsappKey}) {
    // print(
    //     'CheckWhatsappButtonEnable ----> $whatsappTemplate  $whatsappTemplateName $whatsappKey');
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
