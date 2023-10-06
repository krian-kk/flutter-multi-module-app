import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(13.021835, 77.663926), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps Current Location'),
        ),
        body: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ));
  }
}
