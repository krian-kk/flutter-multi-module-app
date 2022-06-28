class AgentDetailsModel {
  AgentDetailsModel({this.code, this.status, this.msg, this.auth, this.data});

  AgentDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['status'] is int) {
      status = json['status'];
    }
    if (json['status'] is String) {
      status = int.parse(json['status']);
    }
    msg = json['msg'];
    auth = json['auth'];
    if (json['result'] != null) {
      data = <Data>[];
      json['result'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  String? code;
  int? status;
  String? msg;
  String? auth;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    data['auth'] = auth;
    if (this.data != null) {
      data['result'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Data(
      {this.agentRef,
      this.agentName,
      this.agentType,
      this.status,
      this.mobileNumber,
      this.contractor,
      this.userAdmin,
      this.email,
      this.contractorPrefix,
      this.mobNo});

  Data.fromJson(Map<String, dynamic> json) {
    agentRef = json['agent_ref'];
    agentName = json['Agent_name'];
    agentType = json['Agent_type'];
    status = json['status'];
    mobileNumber = json['mobileNumber'];
    contractor = json['contractor'];
    userAdmin = json['userAdmin'];
    email = json['email'];
    contractorPrefix = json['contractorPrefix'];
    mobNo = json['mobNo'];
  }

  String? agentRef;
  String? agentName;
  String? agentType;
  String? status;
  String? mobileNumber;
  String? contractor;
  bool? userAdmin;
  String? email;
  String? contractorPrefix;
  String? mobNo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agent_ref'] = agentRef;
    data['Agent_name'] = agentName;
    data['Agent_type'] = agentType;
    data['status'] = status;
    data['mobileNumber'] = mobileNumber;
    data['contractor'] = contractor;
    data['userAdmin'] = userAdmin;
    data['email'] = email;
    data['contractorPrefix'] = contractorPrefix;
    data['mobNo'] = mobNo;
    return data;
  }
}
