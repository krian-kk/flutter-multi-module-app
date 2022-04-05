class DashboardEventCountResult {
  DashboardEventCountResult({
    this.id,
    this.eventType,
    this.eventCode,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  factory DashboardEventCountResult.fromJson(Map<String, dynamic> json) =>
      DashboardEventCountResult(
        id: json['_id'] as String?,
        eventType: json['eventType'] as String?,
        eventCode: json['eventCode'] as String?,
        createdAt: json['createdAt'] as String?,
        createdBy: json['createdBy'] as String?,
        v: json['__v'] as int?,
      );
  String? id;
  String? eventType;
  String? eventCode;
  String? createdAt;
  String? createdBy;
  int? v;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'eventType': eventType,
        'eventCode': eventCode,
        'createdAt': createdAt,
        'createdBy': createdBy,
        '__v': v,
      };
}
