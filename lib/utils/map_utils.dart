import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/env.dart';
import 'package:origa/models/location_converter.dart';
import 'package:origa/singleton.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_utils.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap({
    required double startLatitude,
    required double startLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) async {
    if (Platform.isAndroid) {
      final String googleUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';

      try {
        // AppUtils.showToast("Loading...");
        await launch(googleUrl);
      } catch (e) {
        debugPrint('map not. open ---> $e');
        AppUtils.showErrorToast('Could not open the map.');
      }
    } else if (Platform.isIOS) {
      final String googleUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';

      try {
        // AppUtils.showToast("Loading...");
        await launch(googleUrl);
      } catch (e) {
        debugPrint('map not. open ---> $e');
        AppUtils.showErrorToast('Could not open the map.');
      }
    }
  }

  static Future<Northeast?> convertAddressToLarlng(
      {required String address, required BuildContext context}) async {
    Northeast? addressToLatlngValue;
    try {
      LocationConverterModel getLocationLatLng = LocationConverterModel();
      final String geocodeURL =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=${Singleton.instance.contractorInformations?.result?.googleMapsApiKey}';

      final Map<String, dynamic> getAddressToLatlng =
          await APIRepository.apiRequest(APIRequestType.get, geocodeURL);

      getLocationLatLng =
          LocationConverterModel.fromJson(getAddressToLatlng['data']);
      addressToLatlngValue =
          getLocationLatLng.results!.first.geometry!.location;
    } catch (e) {
      AppUtils.showToast(Languages.of(context)!.invalidAddress);
    }

    return addressToLatlngValue;
  }

  static Future<Position> getCurrentLocation(BuildContext context) async {
    Position? currentLocation;
    // final LocationPermission permission = await Geolocator.checkPermission();
    PermissionStatus status = await Permission.location.status;
    AppUtils.showToast(Languages.of(context)!.loading);

    if (status == PermissionStatus.granted) {
      currentLocation = await Geolocator.getCurrentPosition();
    } else if (status == PermissionStatus.denied) {
      await Geolocator.requestPermission();
    } else if (status == PermissionStatus.permanentlyDenied) {
      await Geolocator.openAppSettings();
    } else {
      currentLocation = await Geolocator.getCurrentPosition();
    }
    return currentLocation!;
  }

// static Future<void> launchMap(
//     {required String startingAddress,
//     required String destinationAddress}) async {
//   if (Platform.isAndroid) {
//     String googleUrl =
//         'https://www.google.com/maps/dir/?api=1&origin=$startingAddress&destination=$destinationAddress&travelmode=driving&dir_action=navigate';
//     if (await canLaunch(googleUrl)) {
//       await launch(googleUrl);
//     } else {
//       AppUtils.showErrorToast("Could not open the map.");
//       // throw 'Could not open the map.';
//     }
//   } else if (Platform.isIOS) {
//     String googleUrl =
//         'https://www.google.com/maps/dir/?api=1&origin=$startingAddress&destination=$destinationAddress&travelmode=driving&dir_action=navigate';
//     if (await canLaunch(googleUrl)) {
//       await launch(googleUrl);
//     } else {
//       AppUtils.showErrorToast("Could not open the map.");
//       // throw 'Could not open the map.';
//     }
//   }
// }

// static Future<String?> getCurrentAddress() async {
//   String? currentAddress;
//   try {
//     Position currentLocation = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);

//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         currentLocation.latitude, currentLocation.longitude);

//     currentAddress = placemarks.toList().first.street.toString() +
//         ', ' +
//         placemarks.toList().first.subLocality.toString() +
//         ', ' +
//         placemarks.toList().first.locality.toString() +
//         ', ' +
//         placemarks.toList().first.administrativeArea.toString() +
//         ', ' +
//         placemarks.toList().first.country.toString() +
//         ', ' +
//         placemarks.toList().first.postalCode.toString();
//   } catch (e) {
//   }
//   return currentAddress;
// }
}
