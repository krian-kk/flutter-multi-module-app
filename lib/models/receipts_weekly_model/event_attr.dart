class EventAttr {
  EventAttr({this.amountCollected, this.appStatus});

  factory EventAttr.fromJson(Map<String, dynamic> json) => EventAttr(
        amountCollected: json['amountCollected'] as int?,
        appStatus: json['appStatus'] as String?,
      );
  int? amountCollected;
  String? appStatus;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amountCollected': amountCollected,
        'appStatus': appStatus,
      };
}
