class AndoridDeviceInfoModel {
  late String platform;
  late String board;
  late String bootloader;
  late String brand;
  late String device;
  late String dislay;
  late String fingerprint;
  late String hardware;
  late String host;
  late String id;
  late String manufacturer;
  late String model;
  late String product;
  late List<String> supported32BitAbis;
  late List<String> supported64BitAbis;
  late List<String> supportedAbis;
  late String tags;
  late String type;
  late bool isPhysicalDevice;
  late String androidId;
  late List<String> systemFeatures;
  late Version version;

  AndoridDeviceInfoModel(
      {this.platform = 'ANDROID',
      required this.board,
      required this.bootloader,
      required this.brand,
      required this.device,
      required this.dislay,
      required this.fingerprint,
      required this.hardware,
      required this.host,
      required this.id,
      required this.manufacturer,
      required this.model,
      required this.product,
      required this.supported32BitAbis,
      required this.supported64BitAbis,
      required this.supportedAbis,
      required this.tags,
      required this.type,
      required this.isPhysicalDevice,
      required this.androidId,
      required this.systemFeatures,
      required this.version});

  AndoridDeviceInfoModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    board = json['board'];
    bootloader = json['bootloader'];
    brand = json['brand'];
    device = json['device'];
    dislay = json['dislay'];
    fingerprint = json['fingerprint'];
    hardware = json['hardware'];
    host = json['host'];
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    product = json['product'];
    supported32BitAbis = json['supported32BitAbis'].cast<String>();
    supported64BitAbis = json['supported64BitAbis'].cast<String>();
    supportedAbis = json['supportedAbis'].cast<String>();
    tags = json['tags'];
    type = json['type'];
    isPhysicalDevice = json['isPhysicalDevice'];
    androidId = json['androidId'];
    systemFeatures = json['systemFeatures'].cast<String>();
    version = Version.fromJson(json['version']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['board'] = board;
    data['bootloader'] = bootloader;
    data['brand'] = brand;
    data['device'] = device;
    data['dislay'] = dislay;
    data['fingerprint'] = fingerprint;
    data['hardware'] = hardware;
    data['host'] = host;
    data['id'] = id;
    data['manufacturer'] = manufacturer;
    data['model'] = model;
    data['product'] = product;
    data['supported32BitAbis'] = supported32BitAbis;
    data['supported64BitAbis'] = supported64BitAbis;
    data['supportedAbis'] = supportedAbis;
    data['tags'] = tags;
    data['type'] = type;
    data['isPhysicalDevice'] = isPhysicalDevice;
    data['androidId'] = androidId;
    data['systemFeatures'] = systemFeatures;
    data['version'] = version.toJson();
    return data;
  }
}

class Version {
  late String securityPatch;
  late String sdkInt;
  late String previewSdkInt;
  late String codename;
  late String release;
  late String incremental;
  late String baseOs;

  Version(
      {required this.securityPatch,
      required this.sdkInt,
      required this.previewSdkInt,
      required this.codename,
      required this.release,
      required this.incremental,
      required this.baseOs});

  Version.fromJson(Map<String, dynamic> json) {
    securityPatch = json['securityPatch'];
    sdkInt = json['sdkInt'];
    previewSdkInt = json['previewSdkInt'];
    codename = json['codename'];
    release = json['release'];
    incremental = json['incremental'];
    baseOs = json['baseOs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['securityPatch'] = securityPatch;
    data['sdkInt'] = sdkInt;
    data['previewSdkInt'] = previewSdkInt;
    data['codename'] = codename;
    data['release'] = release;
    data['incremental'] = incremental;
    data['baseOs'] = baseOs;
    return data;
  }
}
