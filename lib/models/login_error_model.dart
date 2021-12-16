class LoginErrorMessage {
  String? code;
  int? status;
  String? msg;
  String? auth;

  LoginErrorMessage({this.code, this.status, this.msg, this.auth});

  LoginErrorMessage.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
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
