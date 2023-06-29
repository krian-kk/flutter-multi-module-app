class AgentDetailErrorModel {
  AgentDetailErrorModel({this.status, this.msg});

  AgentDetailErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['status']) {
      status = json['status'];
    }
    msg = json['message'];
  }

  int? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = msg;
    return data;
  }
}
