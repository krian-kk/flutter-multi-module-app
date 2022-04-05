import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/home_address_post_model/home_address_post_model.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/map_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';

class MapViewBottomSheetScreen extends StatefulWidget {
  const MapViewBottomSheetScreen({
    Key? key,
    required this.title,
    this.onClose,
  }) : super(key: key);
  final Function? onClose;
  final String title;

  @override
  _MapViewBottomSheetScreenState createState() =>
      _MapViewBottomSheetScreenState();
}

class _MapViewBottomSheetScreenState extends State<MapViewBottomSheetScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(28.644800, 77.216721);
  LatLng position = const LatLng(0, 0);
  Set<Marker> _markers = {};
  LatLng tabLatLng = const LatLng(0, 0);
  String tabAddress = '';

  @override
  void initState() {
    super.initState();
    // getPermission();
    getLocation();
  }

  getLocation() async {
    Position? currentLocation;
    await MapUtils.getCurrentLocation(context).then((value) {
      setState(() {
        currentLocation = value;
        position = LatLng(value.latitude, value.longitude);
        tabLatLng = LatLng(value.latitude, value.longitude);
      });
    });

    final List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    setState(() {
      tabAddress = placemarks.toList().first.street.toString() +
          ', ' +
          placemarks.toList().first.subLocality.toString() +
          ', ' +
          placemarks.toList().first.locality.toString() +
          ',' +
          placemarks.toList().first.postalCode.toString();
    });
    _onAddMarkerButtonPressed();
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onAddMarkerButtonPressed() async {
    final CameraPosition _position1 = CameraPosition(
      // bearing: 192.833,
      target: LatLng(position.latitude, position.longitude),
      tilt: 59.440,
      zoom: 16.0,
    );
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      tabAddress = placemarks.toList().first.street.toString() +
          ', ' +
          placemarks.toList().first.subLocality.toString() +
          ', ' +
          placemarks.toList().first.locality.toString() +
          ',' +
          placemarks.toList().first.postalCode.toString();

      _markers.add(
        Marker(
          markerId: MarkerId(tabAddress),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: tabAddress,
          ),
          // icon: customIcon,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppbar(
              title: widget.title,
              color: ColorResource.color23375A,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers,
              myLocationEnabled: true,
              // polylines: _polyline,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              onTap: (tabPositions) async {
                setState(() {
                  tabLatLng = tabPositions;
                });
                final List<Placemark> placemarks =
                    await placemarkFromCoordinates(
                        tabPositions.latitude, tabPositions.longitude);
                setState(() {
                  tabAddress = placemarks.toList().first.street.toString() +
                      ', ' +
                      placemarks.toList().first.subLocality.toString() +
                      ', ' +
                      placemarks.toList().first.locality.toString() +
                      ',' +
                      placemarks.toList().first.postalCode.toString();
                  _markers = {};
                  _markers.add(
                    Marker(
                      markerId: const MarkerId('Tap Locations'),
                      position: tabPositions,
                      infoWindow: InfoWindow(
                        title: placemarks.toList().first.locality.toString(),
                      ),
                      // icon: customIcon,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                  );
                });
              },
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            color: ColorResource.colorFFFFFF,
            child: Center(
                child: SizedBox(
              width: 190,
              child: CustomButton(
                Languages.of(context)!.done.toUpperCase(),
                fontSize: FontSize.sixteen,
                onTap: () async {
                  if (widget.onClose != null) {
                    // var requestBodyData;
                    // if (tabLatLng.latitude != null) {

                    // } else if (position.latitude != null) {
                    //   requestBodyData = HomeAddressPostModel(
                    //     latitude: position.latitude,
                    //     longitude: position.longitude,
                    //   );
                    // } else {
                    //   AppUtils.topSnackBar(context, "Please Select address!");
                    // }
                    final requestBodyData = HomeAddressPostModel(
                      latitude: position.latitude,
                      longitude: position.longitude,
                      homeAddress: tabAddress,
                    );

                    final Map<String, dynamic> postResult =
                        await APIRepository.apiRequest(
                      APIRequestType.post,
                      HttpUrl.homeAddressUrl(),
                      requestBodydata: jsonEncode(requestBodyData),
                    );

                    if (postResult[Constants.success]) {
                      Navigator.pop(context);
                      AppUtils.topSnackBar(
                          context, Constants.successfullySubmitted);
                      widget.onClose!(tabAddress);
                    } else {}
                  } else {
                    Navigator.pop(context);
                  }
                },
                cardShape: 5,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
