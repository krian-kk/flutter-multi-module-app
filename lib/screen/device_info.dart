import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/device_info_model/android_device_info.dart';
import 'package:origa/models/device_info_model/ios_device_model.dart';

void main() {
  runZonedGuarded(() {
    runApp(const DeviceInfo());
  }, (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
}

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              Platform.isAndroid ? 'Android Device Info' : 'iOS Device Info'),
        ),
        body: ListView(
          children: _deviceData.keys.map((String property) {
            return Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    property,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    '${_deviceData[property]}',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ],
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            try {
              if (Platform.isAndroid) {
                // print('Value => ${_deviceData['version.sdkInt']}');
                // print('');
                var requestBodyData = AndoridDeviceInfoModel(
                  board: _deviceData['board'],
                  bootloader: _deviceData['bootloader'],
                  brand: _deviceData['brand'],
                  device: _deviceData['device'],
                  dislay: _deviceData['display'],
                  fingerprint: _deviceData['fingerprint'],
                  hardware: _deviceData['hardware'],
                  host: _deviceData['host'],
                  id: _deviceData['id'],
                  manufacturer: _deviceData['manufacturer'],
                  model: _deviceData['model'],
                  product: _deviceData['product'],
                  supported32BitAbis: _deviceData['supported32BitAbis'],
                  supported64BitAbis: _deviceData['supported64BitAbis'],
                  supportedAbis: _deviceData['supportedAbis'],
                  tags: _deviceData['tags'],
                  type: _deviceData['type'],
                  isPhysicalDevice: _deviceData['isPhysicalDevice'] as bool,
                  androidId: _deviceData['androidId'],
                  systemFeatures: [],
                  // systemFeatures: ['_deviceData[' ']'],
                  version: Version(
                    securityPatch: _deviceData['version.securityPatch'],
                    sdkInt: _deviceData['version.sdkInt'].toString(),
                    previewSdkInt:
                        _deviceData['version.previewSdkInt'].toString(),
                    codename: _deviceData['version.codename'],
                    release: _deviceData['version.release'],
                    incremental: _deviceData['version.incremental'],
                    baseOs: _deviceData['version.baseOS'],
                  ),
                );
                // print('Request Body => ${requestBodyData}');

                Map<String, dynamic> postResult =
                    await APIRepository.apiRequest(
                  APIRequestType.POST,
                  HttpUrl.mobileInfoUrl,
                  requestBodydata: jsonEncode(requestBodyData.toJson()),
                );
              } else if (Platform.isIOS) {
                var requestBodyData = IOSDeviceInfoModel(
                  name: _deviceData['name'],
                  systemName: _deviceData['systemName'],
                  systemVersion: _deviceData['systemVersion'],
                  model: _deviceData['model'],
                  localizedModel: _deviceData['localizedModel'],
                  identifierForVendor: _deviceData['identifierForVendor'],
                  isPhysicalDevice: _deviceData['isPhysicalDevice'],
                  utsname: Utsname(
                    sysname: _deviceData['utsname.sysname:'],
                    nodename: _deviceData['utsname.nodename:'],
                    release: _deviceData['utsname.release:'],
                    version: _deviceData['utsname.version:'],
                    machine: _deviceData['utsname.machine:'],
                  ),
                  created: _deviceData['utsname.sysname'],
                );
                Map<String, dynamic> postResult =
                    await APIRepository.apiRequest(
                  APIRequestType.POST,
                  HttpUrl.mobileInfoUrl,
                  requestBodydata: jsonEncode(requestBodyData.toJson()),
                );
              }
            } on PlatformException {
              print('Platform Error');
            }
          },
          label: const Text('Clicks'),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
