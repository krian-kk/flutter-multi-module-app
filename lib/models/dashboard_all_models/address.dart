class Address {
  Address({this.cType, this.value});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cType: json['cType'] as String?,
        value: json['value'] as String?,
      );
  String? cType;
  String? value;

  Map<String, dynamic> toJson() => {
        'cType': cType,
        'value': value,
      };
}
