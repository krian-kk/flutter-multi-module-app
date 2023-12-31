class MapMarkerModel {
  MapMarkerModel({
    this.caseId,
    this.address,
    this.due,
    this.name,
    this.latitude,
    this.longitude,
  });

  MapMarkerModel.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    address = json['address'];
    due = json['due'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? caseId;
  String? address;
  String? due;
  String? name;
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseId'] = caseId;
    data['address'] = address;
    data['due'] = due;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
