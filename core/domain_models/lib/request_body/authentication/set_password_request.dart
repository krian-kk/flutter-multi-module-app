class SetPasswordModel {
  SetPasswordModel({
    required this.username,
    required this.newPassword,
  });

  SetPasswordModel.fromJson(Map<String, dynamic> json) {
    username = json['userName'];
    newPassword = json['newPassword'];
  }
  late String username;
  late String newPassword;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = username;
    data['newPassword'] = newPassword;
    return data;
  }
}
