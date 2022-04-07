class IOSDeviceInfoModel {
  IOSDeviceInfoModel({
    this.platform = 'IOS',
    required this.name,
    required this.systemName,
    required this.systemVersion,
    required this.model,
    required this.localizedModel,
    required this.identifierForVendor,
    required this.isPhysicalDevice,
    required this.utsname,
    required this.created,
  });

  IOSDeviceInfoModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    name = json['name'];
    systemName = json['systemName'];
    systemVersion = json['systemVersion'];
    model = json['model'];
    localizedModel = json['localizedModel'];
    identifierForVendor = json['identifierForVendor'];
    isPhysicalDevice = json['isPhysicalDevice'];
    utsname = Utsname.fromJson(json['utsname']);
    created = json['created'];
  }
  late String platform;
  late String name;
  late String systemName;
  late String systemVersion;
  late String model;
  late String localizedModel;
  late String identifierForVendor;
  late bool isPhysicalDevice;
  late Utsname utsname;
  late String? created;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['name'] = name;
    data['systemName'] = systemName;
    data['systemVersion'] = systemVersion;
    data['model'] = model;
    data['localizedModel'] = localizedModel;
    data['identifierForVendor'] = identifierForVendor;
    data['isPhysicalDevice'] = isPhysicalDevice;
    data['utsname'] = utsname.toJson();
    data['created'] = created;
    return data;
  }
}

class Utsname {
  Utsname({
    required this.sysname,
    required this.nodename,
    required this.release,
    required this.version,
    required this.machine,
  });

  Utsname.fromJson(Map<String, dynamic> json) {
    sysname = json['sysname'];
    nodename = json['nodename'];
    release = json['release'];
    version = json['version'];
    machine = json['machine'];
  }
  late String sysname;
  late String nodename;
  late String release;
  late String version;
  late String machine;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sysname'] = sysname;
    data['nodename'] = nodename;
    data['release'] = release;
    data['version'] = version;
    data['machine'] = machine;
    return data;
  }
}
