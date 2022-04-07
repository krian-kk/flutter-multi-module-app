class HomeAddressPostModel {
  HomeAddressPostModel(
      {required this.latitude,
      required this.longitude,
      required this.homeAddress});

  HomeAddressPostModel.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    homeAddress = json['homeAddress'];
  }
  late double latitude;
  late double longitude;
  late String homeAddress;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['homeAddress'] = homeAddress;
    return data;
  }
}
