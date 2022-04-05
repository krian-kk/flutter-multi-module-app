class NotificationMainModel {
  NotificationMainModel(this.date, this.listOfNotification);
  String date;
  List<NotificationChildModel> listOfNotification;
}

class NotificationChildModel {
  NotificationChildModel(this.headText, this.subText);
  String? headText;
  String? subText;
}
