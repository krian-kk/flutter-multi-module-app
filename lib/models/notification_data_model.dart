class NotificationDataModel {
  NotificationDataModel({this.typeOfNotification});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    typeOfNotification = json['typeOfNotification'];
  }
  String? typeOfNotification;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeOfNotification'] = typeOfNotification;
    return data;
  }
}
