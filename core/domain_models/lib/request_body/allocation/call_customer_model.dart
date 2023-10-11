class CallCustomerModel {
  CallCustomerModel({
    required this.from,
    required this.to,
    required this.callerId,
    required this.aRef,
    required this.customerName,
    required this.service,
    this.eventCode = 'TELEVT011',
    required this.callerServiceID,
    required this.caseId,
    required this.sId,
    required this.agrRef,
    required this.agentName,
    required this.agentType,
    required this.contractor,
  });

  CallCustomerModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    callerId = json['callerId'];
    aRef = json['aRef'];
    customerName = json['customerName'];
    service = json['service'];
    eventCode = json['eventCode'];
    callerServiceID = json['callerServiceID'];
    caseId = json['caseId'];
    sId = json['_id'];
    agrRef = json['agrRef'];
    agentName = json['agentName'];
    agentType = json['agentType'];
    contractor = json['contractor'];
  }

  late String from;
  late String to;
  late String callerId;
  late String aRef;
  late String customerName;
  late String service;
  late String eventCode;
  late String? callerServiceID;
  late String caseId;
  late String sId;
  late String agrRef;
  late String agentName;
  late String agentType;
  late String? contractor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['callerId'] = callerId;
    data['aRef'] = aRef;
    data['customerName'] = customerName;
    data['service'] = service;
    data['eventCode'] = eventCode;
    data['callerServiceID'] = callerServiceID;
    data['caseId'] = caseId;
    data['_id'] = sId;
    data['agrRef'] = agrRef;
    data['agentName'] = agentName;
    data['agentType'] = agentType;
    data['contractor'] = contractor;
    return data;
  }
}
