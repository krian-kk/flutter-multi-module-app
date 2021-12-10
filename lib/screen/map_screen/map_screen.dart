import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/screen/map_screen/bloc/map_bloc.dart';

import 'bloc/map_state.dart';

class MapScreen extends StatefulWidget {
  MapBloc bloc;

  MapScreen(this.bloc);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(11.0168, 76.9558);

  final Set<Marker> _markers = {};
  late BitmapDescriptor customIcon;

  final LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    // make sure to initialize before map loading
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)), 'assets/marker.png')
        .then((d) {
      customIcon = d;
    });
    super.initState();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: LatLng(widget.bloc.currentLocation.latitude,
            widget.bloc.currentLocation.longitude),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: customIcon,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    // _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: widget.bloc,
        listener: (BuildContext context, MapState state) {},
        child: BlocBuilder(
          bloc: widget.bloc,
          builder: (BuildContext context, MapState state) {
            return Container(
              height: MediaQuery.of(context).size.height * 80,
              child: Scaffold(
                body: (state is MapLoadingState)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 90),
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: const CameraPosition(
                                target: _center,
                                zoom: 11.0,
                              ),
                              mapType: _currentMapType,
                              markers: _markers,
                              onCameraMove: _onCameraMove,
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: <Widget>[
                                  FloatingActionButton(
                                    onPressed: _onMapTypeButtonPressed,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    backgroundColor: Colors.green,
                                    child: const Icon(Icons.map, size: 36.0),
                                  ),
                                  SizedBox(height: 16.0),
                                  FloatingActionButton(
                                    onPressed: _onAddMarkerButtonPressed,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    backgroundColor: Colors.green,
                                    child: const Icon(Icons.add_location,
                                        size: 36.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        ));
  }
}
