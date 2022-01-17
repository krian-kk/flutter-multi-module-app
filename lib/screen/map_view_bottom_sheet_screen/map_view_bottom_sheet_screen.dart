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
  const MapViewBottomSheetScreen({
    Key? key,
    required this.title,
    this.onClose,
    this.agentLocation,
    this.listOfAgentLocation,
  }) : super(key: key);
  final Function? onClose;
  final String title;
  final String? agentLocation;
  final List<dynamic>? listOfAgentLocation;

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

  // var currentLatitude;
  // var currentLontitude;

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
    if (widget.agentLocation == null &&
        widget.listOfAgentLocation == null &&
        widget.listOfAgentLocation == []) {
      Position res = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // List<Placemark> placemarks =
      //     await placemarkFromCoordinates(res.latitude, res.longitude);

      setState(() {
        position = LatLng(res.latitude, res.longitude);
        tabLatLng = LatLng(res.latitude, res.longitude);

        // tabAddress = placemarks.first.toString();
        // tabAddress = placemarks.toList().first.street.toString() +
        //     ', ' +
        //     placemarks.toList().first.subLocality.toString() +
        //     ', ' +
        //     placemarks.toList().first.locality.toString() +
        //     ',' +
        //     placemarks.toList().first.postalCode.toString();
        // print('------------------locatio---------');
        // print(res.latitude);
      });
      _onAddMarkerButtonPressed();
    } else if (widget.listOfAgentLocation != null &&
        widget.listOfAgentLocation != []) {
      for (var element in widget.listOfAgentLocation!) {
        try {
          List<Location> locations = await locationFromAddress(element);
          setState(() {
            tabAddress = element;
            position =
                LatLng(locations.first.latitude, locations.first.longitude);
          });
          _onAddMarkerButtonPressed();
        } catch (e) {
          print(e);
        }
      }
    } else {
      try {
        List<Location> locations =
            await locationFromAddress(widget.agentLocation!);
        setState(() {
          tabAddress = widget.agentLocation!;
          position =
              LatLng(locations.first.latitude, locations.first.longitude);
        });
        _onAddMarkerButtonPressed();
      } catch (e) {
        Position res = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        setState(() {
          position = LatLng(res.latitude, res.longitude);
        });
        _onAddMarkerButtonPressed();
      }
    }
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
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      // currentLatitude = position.latitude;
      // currentLontitude = position.longitude;

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
              mapType: MapType.normal,
              markers: _markers,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              // polylines: _polyline,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              mapToolbarEnabled: true,
              onTap: (widget.agentLocation == null &&
                      widget.listOfAgentLocation == null)
                  ? (tabPositions) async {
                      setState(() {
                        tabLatLng = tabPositions;
                      });
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              tabPositions.latitude, tabPositions.longitude);
                      setState(() {
                        tabAddress = placemarks
                                .toList()
                                .first
                                .street
                                .toString() +
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
                              title:
                                  placemarks.toList().first.locality.toString(),
                            ),
                            // icon: customIcon,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                          ),
                        );
                      });
                    }
                  : (val) {},
            ),
          ),
          (widget.agentLocation == null && widget.listOfAgentLocation == null)
              ? Container(
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
                        // print('Tap Address => ${placemark}');
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
                          var requestBodyData = HomeAddressPostModel(
                            latitude: position.latitude,
                            longitude: position.longitude,
                            homeAddress: tabAddress,
                          );

                          Map<String, dynamic> postResult =
                              await APIRepository.apiRequest(
                            APIRequestType.POST,
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
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
