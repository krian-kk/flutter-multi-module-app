import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerModel {
  String? caseId;
  String? address;
  String? due;
  String? name;
  double? latitude;
  double? longitude;

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

// class MapResultModel {
//   String? caseId;
//   String? address;
//   String? due;
//   double? latitude;
//   double? longitude;

//   MapResultModel(
//       {this.caseId, this.address, this.due, this.latitude, this.longitude});

//   MapResultModel.fromJson(Map<String, dynamic> json) {
//     caseId = json['caseId'];
//     address = json['address'];
//     due = json['due'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['caseId'] = this.caseId;
//     data['address'] = this.address;
//     data['due'] = this.due;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
