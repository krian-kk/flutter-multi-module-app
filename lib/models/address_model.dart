class AddressDetails {
  String? cType;
  String? health;
  String? value;
  String? resAddressId0;

  AddressDetails({this.cType, this.health, this.value, this.resAddressId0});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    health = json['health'];
    value = json['value'];
    resAddressId0 = json['resAddressId_0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['health'] = health;
    data['value'] = value;
    data['resAddressId_0'] = resAddressId0;
    return data;
  }
}
