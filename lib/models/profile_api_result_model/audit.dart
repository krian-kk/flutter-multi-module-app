class Audit {
  Audit({this.crBy, this.crAt, this.upBy, this.upAt});

  factory Audit.fromJson(Map<String, dynamic> json) => Audit(
        crBy: json['crBy'] as String?,
        crAt: json['crAt'] as String?,
        upBy: json['upBy'] as String?,
        upAt: json['upAt'] as String?,
      );
  String? crBy;
  String? crAt;
  String? upBy;
  String? upAt;

  Map<String, dynamic> toJson() => {
        'crBy': crBy,
        'crAt': crAt,
        'upBy': upBy,
        'upAt': upAt,
      };
}
