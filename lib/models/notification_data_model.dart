class NotificationDataModel {
  String? notificationTitle;
  String? notificationMessage;
  String? typeOfNotification;
  String? caseId;
  String? toAref;

  NotificationDataModel(
      {this.notificationTitle,
      this.notificationMessage,
      this.typeOfNotification,
      this.caseId,
      this.toAref});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    notificationTitle = json['notificationTitle'];
    notificationMessage = json['notificationMessage'];
    typeOfNotification = json['typeOfNotification'];
    caseId = json['caseId'];
    toAref = json['toAref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notificationTitle'] = notificationTitle;
    data['notificationMessage'] = notificationMessage;
    data['typeOfNotification'] = typeOfNotification;
    data['caseId'] = caseId;
    data['toAref'] = toAref;
    return data;
  }
}
