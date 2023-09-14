import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart'; // Stores the Google Maps API Key
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:languages/app_languages.dart';
// import 'dart:math' show cos, sqrt, asin;

import 'package:origa/models/case_details_navigation_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/map_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_dialog.dart';

// enum TravelModes { driving, bicycling, transit, walking }

class MapNavigation extends StatefulWidget {
  const MapNavigation({Key? key, required this.multipleLatLong})
      : super(key: key);
  final List<dynamic> multipleLatLong;

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

  // String? _placeDistance;

  Set<Marker> markers = {};
  MapMarkerModel mapResult = MapMarkerModel();
  PolylineId? id;

  // late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  late BitmapDescriptor customIcon;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    await MapUtils.getCurrentLocation(context).then((Position position) async {
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
      debugPrint(e.toString());
    });
  }

  // Method for calculating the distance between two places
  Future<bool> createMarker() async {
    try {
      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      final double startLatitude = _currentPosition.latitude;
      final double startLongitude = _currentPosition.longitude;

      final String startCoordinatesString = '($startLatitude, $startLongitude)';

      // Start Location Marker
      final Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        infoWindow: const InfoWindow(
          title: 'My Location',
          // snippet: "My Location",
        ),
      );
      // Adding the markers to the list
      markers.add(startMarker);
      final result = jsonDecode(jsonEncode(widget.multipleLatLong));
      for (var element in result) {
        markers.add(Marker(
          markerId: MarkerId('${element['latitude']}, ${element['longitude']}'),
          position: LatLng(element['latitude'], element['longitude']),
          onTap: () {
            DialogUtils.showDialog(
                buildContext: context,
                title: element['name'] ?? '',
                titleTextAlign: TextAlign.start,
                titleTextStyle: const TextStyle(
                    fontSize: FontSize.seventeen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color23375A),
                description: element['address'] ?? '',
                descriptionTextStyle: const TextStyle(
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w400,
                    color: ColorResource.color101010),
                descriptionTextAlign: TextAlign.start,
                okBtnText: Languages.of(context)!.proceed.toUpperCase(),
                cancelBtnText: Languages.of(context)!.cancel.toUpperCase(),
                okBtnFunction: (val) async {
                  Navigator.pop(context);
                  await Navigator.pushNamed(
                      context, AppRoutes.caseDetailsScreen,
                      arguments: CaseDetailsNaviagationModel({
                        'caseID': element['caseId'],
                      }));
                });
          },
          // icon: customIcon,
        ));
      }
      // camera view of the current locatio map
      final GoogleMapController controller = await mapController.future;
      // controller.getVisibleRegion();
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(startLatitude, startLongitude), 13),
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

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
                              await controller.animateCamera(
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
                              await controller.animateCamera(
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
                              await controller.animateCamera(
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
