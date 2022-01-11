class EventAttr {
  int? amountCollected;
  String? appStatus;

  EventAttr({this.amountCollected, this.appStatus});

  factory EventAttr.fromJson(Map<String, dynamic> json) => EventAttr(
        amountCollected: json['amountCollected'] as int?,
        appStatus: json['appStatus'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'amountCollected': amountCollected,
        'appStatus': appStatus,
      };
}
