class AgentDetailErrorModel {
  String? code;
  int? status;
  String? msg;
  String? auth;

  AgentDetailErrorModel({this.code, this.status, this.msg, this.auth});

  AgentDetailErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['status'] is int) {
      status = json['status'];
    }
    if (json['status'] is String) {
      status = int.parse(json['status']);
    }
    msg = json['msg'];
    auth = json['auth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['auth'] = this.auth;
    return data;
  }
}
