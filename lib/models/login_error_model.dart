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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    data['auth'] = auth;
    return data;
  }
}
