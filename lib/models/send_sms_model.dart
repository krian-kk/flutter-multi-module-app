class SendSMS {
  String? agrRef;
  String? agentRef;
  String? type;

  SendSMS({this.agrRef, this.agentRef, this.type});

  SendSMS.fromJson(Map<String, dynamic> json) {
    agrRef = json['agrRef'];
    agentRef = json['agentRef'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agrRef'] = this.agrRef;
    data['agentRef'] = this.agentRef;
    data['type'] = this.type;
    return data;
  }
}
