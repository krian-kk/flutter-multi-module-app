class LocationConverterModel {
  LocationConverterModel({this.results, this.status});

  LocationConverterModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((dynamic v) {
        results!.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Results>? results;
  String? status;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((Results v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Results {
  Results(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.placeId,
      this.types});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((dynamic v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    placeId = json['place_id'];
    types = json['types'].cast<String>();
  }
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<String>? types;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressComponents != null) {
      data['address_components'] =
          addressComponents!.map((AddressComponents v) => v.toJson()).toList();
    }
    data['formatted_address'] = formattedAddress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['place_id'] = placeId;
    data['types'] = types;
    return data;
  }
}

class AddressComponents {
  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }
  String? longName;
  String? shortName;
  List<String>? types;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class Geometry {
  Geometry({this.bounds, this.location, this.locationType, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null;
    location =
        json['location'] != null ? Northeast.fromJson(json['location']) : null;
    locationType = json['location_type'];
    viewport =
        json['viewport'] != null ? Bounds.fromJson(json['viewport']) : null;
  }
  Bounds? bounds;
  Northeast? location;
  String? locationType;
  Bounds? viewport;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bounds != null) {
      data['bounds'] = bounds!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['location_type'] = locationType;
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class Bounds {
  Bounds({this.northeast, this.southwest});

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Northeast.fromJson(json['southwest'])
        : null;
  }
  Northeast? northeast;
  Northeast? southwest;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class Northeast {
  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
