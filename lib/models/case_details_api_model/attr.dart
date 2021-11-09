class Attr {
  String? city;
  String? state;
  String? pincode;

  Attr({this.city, this.state, this.pincode});

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
        city: json['city'] as String?,
        state: json['state'] as String?,
        pincode: json['pincode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'state': state,
        'pincode': pincode,
      };
}
