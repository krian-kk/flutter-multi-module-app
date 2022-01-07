class OTSContact {
  String cType;
  String health;
  String value;

  OTSContact({
    required this.cType,
    required this.health,
    required this.value,
  });

  factory OTSContact.fromJson(Map<String, dynamic> json) => OTSContact(
        cType: json['cType'] as String,
        health: json['health'] as String,
        value: json['value'] as String,
      );

  Map<String, dynamic> toJson() => {
        'cType': cType,
        'health': health,
        'value': value,
      };
}
