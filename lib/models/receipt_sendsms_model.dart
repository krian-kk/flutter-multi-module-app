class ReceiptSendSMS {
  String? borrowerMobile;
  String? agrRef;
  String? agentRef;
  String? messageBody;
  String? type;
  int? receiptAmount;
  String? receiptDate;
  String? paymentMode;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['borrowerMobile'] = this.borrowerMobile;
    data['agrRef'] = this.agrRef;
    data['agentRef'] = this.agentRef;
    data['messageBody'] = this.messageBody;
    data['type'] = this.type;
    data['receiptAmount'] = this.receiptAmount;
    data['receiptDate'] = this.receiptDate;
    data['paymentMode'] = this.paymentMode;
    return data;
  }
}
