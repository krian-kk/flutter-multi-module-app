class SearchListResponse {
  SearchListResponse({
    this.sId,
    this.due,
    this.starredCase = false,
    this.cust,
    this.collSubStatus,
    this.telSubStatus,
    this.followUpPriority,
    this.customerId,
    this.pincode,
    this.caseId,
    this.agrRef,
    this.bankName,
    this.fieldfollowUpDate,
    this.sortId,
    this.followUpDate,
    this.locationType,
    this.distanceMeters,
    this.repoStatus,
    this.accNo,
    this.address,
    this.location,
  });

  SearchListResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    starredCase = json['starredCase'] ?? false;
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    telSubStatus = json['telSubStatus'];
    followUpPriority = json['followUpPriority'];
    customerId = json['customerId'];
    pincode = json['pincode'];
    caseId = json['caseId'];
    agrRef = json['agrRef'] ?? '-';
    bankName = json['bankName'] ?? '-';

    sortId = json['sortId'];
    // followUpDate = json['followUpDate'];
    // Here we will check which user logged in then only set followUpDate
    if (json['telSubStatus'] != null &&
        json['telSubStatus'].toString().toLowerCase() == 'new') {
      if (json['followUpDate'] == null || json['followUpDate'] != '') {
        followUpDate = DateTime.now().toString();
      } else {
        followUpDate = json['followUpDate'];
      }
    } else {
      followUpDate = json['followUpDate'];
    }

    locationType = json['locationType'];
    distanceMeters = json['distanceMeters'];
    repoStatus = json['repoStatus'];
    accNo = json['accNo'];
    if (json['contact'] != null) {
      address = <Address>[];
      json['contact'].forEach((dynamic v) {
        address?.add(Address.fromJson(v));
      });
      if (address!.isNotEmpty) {
        address?.sort((Address a, Address b) =>
            (b.health ?? '1.5').compareTo(a.health ?? '1.5'));
      }
    } else {
      address = <Address>[];
      json['address'].forEach((dynamic v) {
        address?.add(Address.fromJson(v));
      });
    }
    if (json['location'] != null && json['location'] is! String) {
      location = Location.fromJson(json['location']);
    }
  }

  String? sId;
  dynamic due;
  late bool starredCase;
  String? cust;
  String? collSubStatus;
  String? telSubStatus;
  String? followUpPriority;
  String? customerId;
  String? pincode;
  String? caseId;
  String? agrRef;
  String? bankName;
  String? fieldfollowUpDate;
  dynamic sortId;
  String? followUpDate;
  String? locationType;
  dynamic distanceMeters;
  String? repoStatus;
  String? accNo;
  List<Address>? address;
  Location? location;
  bool? isCompletedSuccess = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['due'] = due;
    data['starredCase'] = starredCase;
    data['cust'] = cust;
    data['collSubStatus'] = collSubStatus;
    data['telSubStatus'] = telSubStatus;
    data['followUpPriority'] = followUpPriority;
    data['customerId'] = customerId;
    data['pincode'] = pincode;
    data['caseId'] = caseId;
    data['agrRef'] = agrRef;
    data['bankName'] = bankName;
    data['fieldfollowUpDate'] = fieldfollowUpDate;
    data['sortId'] = sortId;
    if (address != null) {
      data['address'] = address?.map((Address v) => v.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Address {
  Address({this.cType, this.value, this.health});

  Address.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    health = json['health'] ?? '1.5';
  }

  String? cType;
  String? value;
  String? health;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    data['health'] = health;
    return data;
  }
}

class Location {
  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
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
