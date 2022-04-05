class Address {
  Address({this.cType, this.name});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cType: json['cType'] as String?,
        name: json['cType'] as String?,
      );
  String? cType;
  String? name;

  Map<String, dynamic> toJson() => {
        'cType': cType,
        'name': cType,
      };
}
