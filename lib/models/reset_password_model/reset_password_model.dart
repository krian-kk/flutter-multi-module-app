class ResetPasswordModel {
  late String otp;
  late String username;
  late String newPassword;

  ResetPasswordModel({
    required this.otp,
    required this.username,
    required this.newPassword,
  });

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    username = json['username'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['username'] = username;
    data['newPassword'] = newPassword;
    return data;
  }
}
