class EventExpandModel {
  EventExpandModel({
    this.expanded = false,
    required this.header,
    required this.date,
    required this.colloctorID,
    required this.remarks,
  });

  bool expanded;
  String header;
  String date;
  String colloctorID;
  String remarks;
}
