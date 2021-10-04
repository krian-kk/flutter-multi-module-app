class NotificationMainModel {
  String date;
  List<NotificationChildModel> listOfNotification;
  NotificationMainModel(this.date, this.listOfNotification);
}

class NotificationChildModel {
  String? headText;
  String? subText;
  NotificationChildModel(this.headText, this.subText);
}
