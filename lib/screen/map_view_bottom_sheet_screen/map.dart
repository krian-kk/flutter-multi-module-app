import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'dart:math' show cos, sqrt, asin;

import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/map_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_dialog.dart';

enum TravelModes { driving, bicycling, transit, walking }

class MapNavigation extends StatefulWidget {
  final List<dynamic>? multipleLatLong;
  const MapNavigation({Key? key, this.multipleLatLong}) : super(key: key);
  @override
  _MapNavigationState createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  // late GoogleMapController mapController;
  Completer<GoogleMapController> mapController = Completer();
  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  late Position _currentPosition;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String? _placeDistance;

  Set<Marker> markers = {};
  MapMarkerModel mapResult = MapMarkerModel();
  PolylineId? id;

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  late BitmapDescriptor customIcon;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // make sure to initialize before map loading
    // BitmapDescriptor.fromAssetImage(
    //         const ImageConfiguration(size: Size(20, 20)), 'assets/marker.png')
    //     .then((d) {
    //   customIcon = d;
    // });
    super.initState();
    _getCurrentLocation();
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    await MapUtils.getCurrentLocation().then((Position position) async {
      setState(() {
        _currentPosition = position;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await createMarker();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for calculating the distance between two places
  Future<bool> createMarker() async {
    try {
      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _currentPosition.latitude;
      double startLongitude = _currentPosition.longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        anchor: const Offset(0.5, 1.0),
        position: LatLng(startLatitude, startLongitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'My Location',
          // snippet: "My Location",
        ),
      );
      // Adding the markers to the list
      markers.add(startMarker);

      // if (widget.multipleLatLong!.length == 1 &&
      //     widget.multipleLatLong!.isNotEmpty) {
      //   double destinationLatitude = 0.0;
      //   double destinationLongitude = 0.0;
      //   var result = jsonDecode(jsonEncode(widget.multipleLatLong!));
      //   setState(() {
      //     destinationLatitude = result[0]['latitude'];
      //     destinationLongitude = result[0]['longitude'];
      //   });

      //   String destinationCoordinatesString =
      //       '($destinationLatitude, $destinationLongitude)';
      //   // Destination Location Marker
      //   Marker destinationMarker = Marker(
      //     markerId: MarkerId(destinationCoordinatesString),
      //     position: LatLng(destinationLatitude, destinationLongitude),
      //     onTap: () {
      //       DialogUtils.showDialog(
      //           buildContext: context,
      //           title: result[0]['name'] ?? "",
      //           titleTextAlign: TextAlign.start,
      //           titleTextStyle: const TextStyle(
      //               fontSize: FontSize.seventeen,
      //               fontWeight: FontWeight.w700,
      //               color: ColorResource.color23375A),
      //           description: result[0]['address'] ?? "",
      //           descriptionTextStyle: const TextStyle(
      //               fontSize: FontSize.fourteen,
      //               fontWeight: FontWeight.w400,
      //               color: ColorResource.color101010),
      //           descriptionTextAlign: TextAlign.start,
      //           okBtnText: Languages.of(context)!.cancel.toUpperCase(),
      //           // cancelBtnText: Languages.of(context)!.cancel.toUpperCase(),
      //           okBtnFunction: (val) async {
      //             Navigator.pop(context);
      //           });
      //     },
      //     icon: customIcon,
      //   );

      //   markers.add(destinationMarker);

      //   // Calculating to check that the position relative
      //   // to the frame, and pan & zoom the camera accordingly.
      //   double miny = (startLatitude <= destinationLatitude)
      //       ? startLatitude
      //       : destinationLatitude;
      //   double minx = (startLongitude <= destinationLongitude)
      //       ? startLongitude
      //       : destinationLongitude;
      //   double maxy = (startLatitude <= destinationLatitude)
      //       ? destinationLatitude
      //       : startLatitude;
      //   double maxx = (startLongitude <= destinationLongitude)
      //       ? destinationLongitude
      //       : startLongitude;

      //   double southWestLatitude = miny;
      //   double southWestLongitude = minx;

      //   double northEastLatitude = maxy;
      //   double northEastLongitude = maxx;

      //   // Accommodate the two locations within the
      //   // camera view of the map
      //   final GoogleMapController controller = await mapController.future;
      //   controller.animateCamera(
      //     CameraUpdate.newLatLngBounds(
      //       LatLngBounds(
      //         northeast: LatLng(northEastLatitude, northEastLongitude),
      //         southwest: LatLng(southWestLatitude, southWestLongitude),
      //       ),
      //       100.0,
      //     ),
      //   );
      //   setState(() {
      //     id = PolylineId(
      //         destinationLatitude.toString() + destinationLongitude.toString());
      //   });
      //   // await _createPolylines(startLatitude, startLongitude,
      //   //     destinationLatitude, destinationLongitude);
      // } else {
      var result = jsonDecode(jsonEncode(widget.multipleLatLong!));
      // print(jsonEncode(widget.multipleLatLong!));
      // mapResult = MapMarkerModel.fromJson(result[0]);
      for (var element in result) {
        markers.add(Marker(
          markerId: MarkerId(element['latitude'].toString() +
              ", " +
              element['longitude'].toString()),
          position: LatLng(element['latitude'], element['longitude']),
          onTap: () {
            DialogUtils.showDialog(
                buildContext: context,
                title: element['name'] ?? "",
                titleTextAlign: TextAlign.start,
                titleTextStyle: const TextStyle(
                    fontSize: FontSize.seventeen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color23375A),
                description: element['address'] ?? "",
                descriptionTextStyle: const TextStyle(
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w400,
                    color: ColorResource.color101010),
                descriptionTextAlign: TextAlign.start,
                okBtnText: Languages.of(context)!.submit.toUpperCase(),
                cancelBtnText: Languages.of(context)!.cancel.toUpperCase(),
                okBtnFunction: (val) async {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
                      arguments: {
                        'caseID': element['caseId'],
                      });
                });
          },
          // icon: customIcon,
        ));
      }
      // camera view of the current locatio map
      final GoogleMapController controller = await mapController.future;
      // controller.getVisibleRegion();
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(startLatitude, startLongitude), 13),
      );
      // }

      // print(
      //   'START COORDINATES: ($startLatitude, $startLongitude)',
      // );

      // double totalDistance = 0.0;

      // // Calculating the total distance by adding the distance
      // // between small segments
      // for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      //   totalDistance += _coordinateDistance(
      //     polylineCoordinates[i].latitude,
      //     polylineCoordinates[i].longitude,
      //     polylineCoordinates[i + 1].latitude,
      //     polylineCoordinates[i + 1].longitude,
      //   );
      // }

      // setState(() {
      //   _placeDistance = totalDistance.toStringAsFixed(2);
      //   print('DISTANCE: $_placeDistance km');
      // });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // // https://stackoverflow.com/a/54138876/11910277
  // double _coordinateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  // // Create the polylines for showing the route between two places
  // _createPolylines(
  //   double startLatitude,
  //   double startLongitude,
  //   double destinationLatitude,
  //   double destinationLongitude,
  // ) async {
  //   polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     Env.googleMapAPI, // Google Maps API Key
  //     PointLatLng(startLatitude, startLongitude),
  //     PointLatLng(destinationLatitude, destinationLongitude),
  //     travelMode: TravelMode.transit,
  //   );
  //   print("poly line result------>");
  //   print(result.points);
  //   print(result.errorMessage);
  //   print(result.status);

  //   // String polyLineApi =
  //   //     "https://maps.googleapis.com/maps/api/directions/json?";

  //   // Map<String, dynamic> polylineData = await APIRepository.apiRequest(
  //   //     APIRequestType.GET,
  //   //     polyLineApi +
  //   //         "origin=$startLatitude,$startLongitude&" +
  //   //         "destination=$destinationLatitude,$destinationLongitude&" +
  //   //         "mode=transit&" +
  //   //         "avoidHighways=false&" +
  //   //         "avoidFerries=true&" +
  //   //         "avoidTolls=false&" +
  //   //         "key=$googleMapAPI");

  //   // print("--------------NK-------------");
  //   // print(polylineData);

  //   // Here clear the previous polyline then added newly selected LatLng polyline
  //   polylineCoordinates.clear();
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       setState(() {
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       });
  //     }
  //   }

  //   Polyline polyline = Polyline(
  //       polylineId: id!,
  //       color: Colors.blue,
  //       points: polylineCoordinates,
  //       width: 5,
  //       jointType: JointType.round);
  //   polylines[id!] = polyline;
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Map View
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetAppbar(
                    title: Languages.of(context)!.mapView,
                    color: ColorResource.color23375A,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10)),
                Expanded(
                  child: GoogleMap(
                    key: ValueKey(MediaQuery.of(context).orientation),
                    markers: Set<Marker>.from(markers),
                    initialCameraPosition: _initialLocation,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    polylines: Set<Polyline>.of(polylines.values),
                    onMapCreated: (GoogleMapController controller) {
                      mapController.complete(controller);
                    },
                  ),
                ),
              ],
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: Material(
                          color: ColorResource.colorE96F4A, // button color
                          child: InkWell(
                            splashColor:
                                ColorResource.color23375A, // inkwell color
                            child: const SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(Icons.add,
                                  color: ColorResource.colorFEFFFF),
                            ),
                            onTap: () async {
                              final GoogleMapController controller =
                                  await mapController.future;
                              controller.animateCamera(
                                CameraUpdate.zoomIn(),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ClipOval(
                        child: Material(
                          color: ColorResource.colorE96F4A, // button color
                          child: InkWell(
                            splashColor:
                                ColorResource.color23375A, // inkwell color
                            child: const SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(Icons.remove,
                                  color: ColorResource.colorFEFFFF),
                            ),
                            onTap: () async {
                              final GoogleMapController controller =
                                  await mapController.future;
                              controller.animateCamera(
                                CameraUpdate.zoomOut(),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ClipOval(
                        child: Material(
                          color: ColorResource.colorffffff, // button color
                          child: InkWell(
                            splashColor:
                                ColorResource.colorE96F4A, // inkwell color
                            child: const SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.my_location,
                                color: Colors.blueGrey,
                              ),
                            ),
                            onTap: () async {
                              final GoogleMapController controller =
                                  await mapController.future;
                              controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      _currentPosition.latitude,
                                      _currentPosition.longitude,
                                    ),
                                    zoom: 18.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
