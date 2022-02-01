import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/env.dart';
import 'package:origa/models/location_converter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_utils.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
      {required double startLatitude,
      required double startLongitude,
      required double destinationLatitude,
      required double destinationLongitude}) async {
    if (Platform.isAndroid) {
      String googleUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';

      try {
        // AppUtils.showToast("Loading...");
        await launch(googleUrl);
      } catch (e) {
        debugPrint("map not. open ---> ${e}");
        AppUtils.showErrorToast("Could not open the map.");
      }
    } else if (Platform.isIOS) {
      String googleUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';

      try {
        // AppUtils.showToast("Loading...");
        await launch(googleUrl);
      } catch (e) {
        debugPrint("map not. open ---> ${e}");
        AppUtils.showErrorToast("Could not open the map.");
      }
    }
  }

  static Future<Northeast?> convertAddressToLarlng(
      {required String address}) async {
    Northeast? addressToLatlngValue;
    try {
      LocationConverterModel getLocationLatLng = LocationConverterModel();
      String geocodeURL =
          "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=${Env.googleMapAPI}";

      Map<String, dynamic> getAddressToLatlng =
          await APIRepository.apiRequest(APIRequestType.GET, geocodeURL);
      getLocationLatLng =
          LocationConverterModel.fromJson(getAddressToLatlng['data']);
      addressToLatlngValue = getLocationLatLng.results![0].geometry!.location;
    } catch (e) {
      // print(e);
      AppUtils.showToast("Invalid Address");
    }

    return addressToLatlngValue;
  }

  static Future<Position> getCurrentLocation() async {
    Position? currentLocation;
    LocationPermission permission = await Geolocator.checkPermission();
    print(" checking permission ===> ${permission.toString()}");

    AppUtils.showToast("Loading...");

    if (permission.toString() == LocationPermission.whileInUse.toString()) {
      // print('Permission Granted');
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } else if (permission.toString() == LocationPermission.denied.toString()) {
      await Geolocator.requestPermission();
    } else if (permission.toString() ==
        LocationPermission.deniedForever.toString()) {
      await Geolocator.openAppSettings();
    } else {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    }
    print("current location ----> ${currentLocation}");
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
  //     print(e);
  //   }
  //   // print(currentAddress);
  //   return currentAddress;
  // }
}
