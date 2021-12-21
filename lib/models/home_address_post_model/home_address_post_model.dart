class HomeAddressPostModel {
  late double latitude;
  late double longitude;

  HomeAddressPostModel({required this.latitude, required this.longitude});

  HomeAddressPostModel.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    return data;
  }
}
