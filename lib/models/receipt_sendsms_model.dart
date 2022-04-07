class ReceiptSendSMS {
  ReceiptSendSMS(
      {this.borrowerMobile,
      this.agrRef,
      this.agentRef,
      this.messageBody,
      this.type,
      this.receiptAmount,
      this.receiptDate,
      this.paymentMode});

  ReceiptSendSMS.fromJson(Map<String, dynamic> json) {
    borrowerMobile = json['borrowerMobile'];
    agrRef = json['agrRef'];
    agentRef = json['agentRef'];
    messageBody = json['messageBody'];
    type = json['type'];
    receiptAmount = json['receiptAmount'];
    receiptDate = json['receiptDate'];
    paymentMode = json['paymentMode'];
  }
  String? borrowerMobile;
  String? agrRef;
  String? agentRef;
  String? messageBody;
  String? type;
  int? receiptAmount;
  String? receiptDate;
  String? paymentMode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['borrowerMobile'] = borrowerMobile;
    data['agrRef'] = agrRef;
    data['agentRef'] = agentRef;
    data['messageBody'] = messageBody;
    data['type'] = type;
    data['receiptAmount'] = receiptAmount;
    data['receiptDate'] = receiptDate;
    data['paymentMode'] = paymentMode;
    return data;
  }
}
