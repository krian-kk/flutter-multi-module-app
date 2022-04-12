class Audit {
  Audit({
    this.crBy,
    this.crAt,
    this.sourcingFlag,
    this.upBy,
    this.upAt,
    this.allocatedAt,
    this.allocatedBy,
  });

  factory Audit.fromJson(Map<String, dynamic> json) => Audit(
        crBy: json['crBy'] as String?,
        crAt: json['crAt'] as String?,
        sourcingFlag: json['sourcingFlag'] as String?,
        upBy: json['upBy'] as String?,
        upAt: json['upAt'] as String?,
        allocatedAt: json['allocatedAt'] as String?,
        allocatedBy: json['allocatedBy'] as String?,
      );
  String? crBy;
  String? crAt;
  String? sourcingFlag;
  String? upBy;
  String? upAt;
  String? allocatedAt;
  String? allocatedBy;

  Map<String, dynamic> toJson() => {
        'crBy': crBy,
        'crAt': crAt,
        'sourcingFlag': sourcingFlag,
        'upBy': upBy,
        'upAt': upAt,
        'allocatedAt': allocatedAt,
        'allocatedBy': allocatedBy,
      };
}
