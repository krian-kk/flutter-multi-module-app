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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agrRef'] = agrRef;
    data['agentRef'] = agentRef;
    data['type'] = type;
    return data;
  }
}
