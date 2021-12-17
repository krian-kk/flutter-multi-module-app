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
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';

class MapViewBottomSheetScreen extends StatefulWidget {
  const MapViewBottomSheetScreen({Key? key, required this.title, this.onClose})
      : super(key: key);
  final Function? onClose;
  final String title;

  @override
  _MapViewBottomSheetScreenState createState() =>
      _MapViewBottomSheetScreenState();
}

class _MapViewBottomSheetScreenState extends State<MapViewBottomSheetScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(28.644800, 77.216721);
  late Position position;
  Set<Marker> _markers = {};
  LatLng tabLatLng = const LatLng(0.0, 0.0);
  late String? tabAddress;

  // Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.toString() != PermissionStatus.granted.toString()) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission.toString() != PermissionStatus.granted.toString()) {
        getLocation();
      }
      return;
    }
    getLocation();
  }

  void getLocation() async {
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      position = res;
    });
    // print("------------------Nandhu---------------");
    // print(position.latitude);
    _onAddMarkerButtonPressed();
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onAddMarkerButtonPressed() async {
    final CameraPosition _position1 = CameraPosition(
      // bearing: 192.833,
      target: LatLng(position.latitude, position.longitude),
      tilt: 59.440,
      zoom: 16.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
    setState(() {
      // currentLatitude = position.latitude;
      // currentLontitude = position.longitude;

      _markers.add(
        Marker(
          markerId: const MarkerId("current location"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(
            title: 'current location',
          ),
          // icon: customIcon,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
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
                  mapType: MapType.normal,
                  markers: _markers,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  // polylines: _polyline,
                  compassEnabled: false,
                  tiltGesturesEnabled: false,
                  mapToolbarEnabled: true,
                  onTap: (tabPositions) async {
                    setState(() {
                      tabLatLng = tabPositions;
                    });
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        tabPositions.latitude, tabPositions.longitude);
                    setState(() {
                      tabAddress =
                          placemarks.toList().first.locality.toString() +
                              ', ' +
                              placemarks.toList().first.subLocality.toString();
                      _markers = {};
                      _markers.add(
                        Marker(
                          markerId: const MarkerId('Tap Locations'),
                          position: tabPositions,
                          infoWindow: InfoWindow(
                            title:
                                placemarks.toList().first.locality.toString(),
                          ),
                          // icon: customIcon,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
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
                    fontWeight: FontWeight.w600,
                    onTap: () async {
                      var requestBodyData = HomeAddressPostModel(
                        latitude: tabLatLng.latitude,
                        longitude: tabLatLng.longitude,
                      );
                      Map<String, dynamic> postResult =
                          await APIRepository.apiRequest(
                        APIRequestType.POST,
                        HttpUrl.homeAddressUrl(),
                        requestBodydata: jsonEncode(requestBodyData),
                      );

                      if (postResult[Constants.success]) {
                        AppUtils.topSnackBar(
                            context, Constants.successfullySubmitted);
                        widget.onClose!(tabAddress);
                        Navigator.pop(context);
                      }
                    },
                    cardShape: 5,
                  ),
                )),
              ),
            ],
          ),
        ));
  }
}
