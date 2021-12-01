class Address {
  String? cType;
  String? name;
  Address({this.cType, this.name});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cType: json['cType'] as String?,
        name: json['cType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'cType': cType,
        'name': cType,
      };
}
