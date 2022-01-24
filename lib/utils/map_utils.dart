import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    } else if (Platform.isIOS) {
      String googleUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
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
}
