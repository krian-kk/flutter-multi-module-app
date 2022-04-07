class Attr {
  Attr({this.city, this.state, this.pincode});

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
        city: json['city'] as String?,
        state: json['state'] as String?,
        pincode: json['pincode'] as String?,
      );

  String? city;
  String? state;
  String? pincode;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'city': city,
        'state': state,
        'pincode': pincode,
      };
}
