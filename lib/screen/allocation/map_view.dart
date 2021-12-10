import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class MapView extends StatefulWidget {
  final AllocationBloc bloc;
  List<String> listOfCity = [
    'DNYANRAJ AGRO PRODUCT',
    'SHOP NO 2 DNYANRAJ BUILDING',
    'EAGLE LOGISTICS',
  ];
  MapView(this.bloc, {Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late BitmapDescriptor customIcon;
  late Position position;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(28.644800, 77.216721);
  final Set<Marker> _markers = {};
  final MapType _currentMapType = MapType.normal;
  late String addressLine;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)), 'assets/marker.png')
        .then((d) {
      customIcon = d;
    });

    getCurrentLocation();
    getPermission();
    super.initState();
  }

  // Future<void> _getPermission() async {
  //   final PermissionStatus permission = await Permission.location.request();
  //   if (permission == PermissionStatus.granted) {
  //       getLocation();
  //     } else {
  //       await DialogUtils.showDialog(
  //         buildContext: context,
  //         //Sample title like: Languages.of(buildContext)!.smsSendDescription,
  //         title: '"Origa.ai" wants to access your Contacts',
  //         //Sample Description like: Languages.of(buildContext)!.smsSendDescriptionNote,
  //         description:
  //             'To Allow Location Access in App Settings',
  //         okBtnText: 'Allow',
  //         cancelBtnText: 'Deny',
  //         okBtnFunction: (String value) async {
  //           await openAppSettings();
  //         },
  //       );
  //     }
  //   }

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted) getLocation();
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

  getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.toString() != PermissionStatus.granted.toString()) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission.toString() != PermissionStatus.granted.toString()) {
        addMarkers();
      }
      return;
    }
    addMarkers();
  }

  addMarkers() async {
    for (var i in widget.listOfCity) {
      // List<Location> locations =
      //     await locationFromAddress('Gronausestraat 710, Enschede');
      // print('Location => $locations');
      // _markers.add(Marker(
      //   markerId: MarkerId('Marker_current ' + i),
      //   position: LatLng(locations.first.latitude, locations.first.longitude),
      //   infoWindow: InfoWindow(
      //     title: i,
      //     // snippet: 'Bus Stop',
      //   ),
      //   onTap: () {
      //     setState(() {
      //       print("dkldjd");
      //       // _polyline.add(Polyline(
      //       //   polylineId: PolylineId('1'),
      //       //   visible: true,
      //       //   width: 1,
      //       //   points: [
      //       //     LatLng(currentLatitude, currentLontitude),
      //       //     LatLng(locations.first.latitude, locations.first.longitude),
      //       //   ],
      //       //   color: Colors.red,
      //       //   jointType: JointType.bevel,
      //       // ));
      //     });
      //   },
      //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      // ));
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // void _onMapTypeButtonPressed() {
  //   setState(() {
  //     _currentMapType = _currentMapType == MapType.normal
  //         ? MapType.satellite
  //         : MapType.normal;
  //   });
  // }

  void _onAddMarkerButtonPressed() async {
    final CameraPosition _position1 = CameraPosition(
      bearing: 192.833,
      target: LatLng(position.latitude, position.longitude),
      tilt: 59.440,
      zoom: 16.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId("current location"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(
            title: 'current location',
          ),
          icon: customIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 0, 5, 0),
                    child: BottomSheetAppbar(
                      title: Languages.of(context)!.mapView,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 16),
                      onTap: () {
                        widget.bloc.add(FilterSelectOptionEvent());
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      mapType: _currentMapType,
                      markers: _markers,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                    ),
                  ),
                ],
              ));
        }),
      ),
    );
  }

  Widget tapButton(Function onTap, IconData icon) {
    return FloatingActionButton(
      onPressed: () {
        onTap();
      },
      mini: true,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Color(0xFF188D3D),
      child: Icon(
        icon,
      ),
    );
  }
}
