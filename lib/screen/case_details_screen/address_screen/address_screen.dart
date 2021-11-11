// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_not_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/invalid_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/event_details_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class AddressScreen extends StatefulWidget {
  final CaseDetailsBloc bloc;
  AddressScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<CustomerMetNotButtonModel> customerMetNotButtonList = [
    //   CustomerMetNotButtonModel(Languages.of(context)!.leftMessage),
    //   CustomerMetNotButtonModel(Languages.of(context)!.doorLocked),
    //   CustomerMetNotButtonModel(Languages.of(context)!.entryRestricted),
    // ];
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        // backgroundColor: ColorResource.colorF7F8FA,
        body: DefaultTabController(
          length: 3,
          child: Container(
            decoration: new BoxDecoration(
                color: ColorResource.colorFFFFFF,
                boxShadow: [
                  new BoxShadow(
                    color: ColorResource.colorCACACA.withOpacity(.25),
                    blurRadius: 20.0,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
                borderRadius:
                    new BorderRadius.vertical(top: Radius.circular(30))),
            width: double.infinity,
            child: Column(
              children: [
                // CustomAppbar(
                //   titleString: Languages.of(context)!.caseDetials,
                //   titleSpacing: 21,
                //   iconEnumValues: IconEnum.back,
                //   onItemSelected: (value) {
                //     if (value == 'IconEnum.back') {
                //       Navigator.pop(context);
                //       Navigator.pop(context);
                //     }
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'ADDRESS 01',
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.fourteen,
                            fontStyle: FontStyle.normal,
                            color: ColorResource.color23375A,
                          ),
                          Wrap(
                            spacing: 27,
                            children: [
                              Image.asset(ImageResource.activePerson),
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Image.asset(ImageResource.close))
                            ],
                          )
                        ],
                      ),
                      Flexible(
                        child: SizedBox(
                          width: 255,
                          child: CustomText(
                            '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.fourteen,
                            fontStyle: FontStyle.normal,
                            color: ColorResource.color23375A,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () => openViewMapBottomSheet(context),
                            child: SizedBox(
                                width: 10,
                                child: Container(
                                    decoration: new BoxDecoration(
                                        color: ColorResource.colorBEC4CF,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(75.0))),
                                    child: Row(
                                      children: [
                                        Image.asset(ImageResource.direction),
                                        SizedBox(width: 10),
                                        CustomText(
                                          StringResource.viewMap,
                                          fontSize: FontSize.fourteen,
                                          fontWeight: FontWeight.w700,
                                          color: ColorResource.color23375A,
                                        )
                                      ],
                                    ))),
                          )),
                          SizedBox(width: 40),
                          Expanded(
                              child: CustomButton(
                            Languages.of(context)!.eventDetails,
                            onTap: () => openEventDetailsBottomSheet(context),
                            textColor: ColorResource.color23375A,
                            borderColor: ColorResource.color23375A,
                            buttonBackgroundColor: ColorResource.colorFFFFFF,
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: ColorResource.colorD8D8D8))),
                  child: TabBar(
                    isScrollable: true,
                    controller: _controller,
                    indicatorColor: ColorResource.colorD5344C,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color23375A,
                        fontSize: FontSize.fourteen,
                        fontStyle: FontStyle.normal),
                    indicatorWeight: 5.0,
                    labelColor: ColorResource.color23375A,
                    unselectedLabelColor: ColorResource.colorC4C4C4,
                    onTap: (index) {
                      widget.bloc.addressCustomerNotMetNextActionDateFocusNode
                          .unfocus();
                      widget.bloc.addressCustomerNotMetRemarksFocusNode
                          .unfocus();
                      widget.bloc.addressInvalidRemarksFocusNode.unfocus();
                    },
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(text: Languages.of(context)!.customerMet),
                      Tab(text: Languages.of(context)!.customerNotMet),
                      Tab(text: Languages.of(context)!.invalid)
                    ],
                  ),
                ),

                Expanded(
                    child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: TabBarView(
                            controller: _controller,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              CustomerMetScreen(
                                  bloc: widget.bloc, context: context),
                              CustomerNotMetScreen(
                                  context: context, bloc: widget.bloc),
                              AddressInvalidScreen(
                                  context: context, bloc: widget.bloc),
                            ],
                          ),
                        ),
                      ])
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: _controller.index == 0
            ? Container(
                height: 75,
                decoration: BoxDecoration(
                  color: ColorResource.colorFFFFFF,
                  boxShadow: [
                    new BoxShadow(
                      color: ColorResource.color000000.withOpacity(.25),
                      blurRadius: 2.0,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 190,
                        child: CustomButton(
                          Languages.of(context)!.done.toUpperCase(),
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          onTap: () => Navigator.pop(context),
                          cardShape: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 75,
                decoration: BoxDecoration(
                  color: ColorResource.colorFFFFFF,
                  boxShadow: [
                    new BoxShadow(
                      color: ColorResource.color000000.withOpacity(.25),
                      blurRadius: 2.0,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 95,
                          child: Center(
                              child: CustomText(
                            Languages.of(context)!.cancel.toUpperCase(),
                            onTap: () => Navigator.pop(context),
                            color: ColorResource.colorEA6D48,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: FontSize.sixteen,
                          ))),
                      SizedBox(width: 25),
                      SizedBox(
                        width: 191,
                        child: _controller.index == 1
                            ? CustomButton(
                                Languages.of(context)!.submit.toUpperCase(),
                                // isEnabled: (bloc.selectedUnreadableClip == ''),
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w600,
                                // onTap: () => bloc.add(ClickMessageEvent()),
                                cardShape: 5,
                              )
                            : CustomButton(
                                Languages.of(context)!.submit.toUpperCase(),
                                // isEnabled: (bloc.selectedInvalidClip != ''),
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w600,
                                // onTap: () => bloc.add(ClickMessageEvent()),
                                cardShape: 5,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  openEventDetailsBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return CustomEventDetailsBottomSheet(
            Languages.of(context)!.eventDetails.toUpperCase(), widget.bloc);
      },
    );
  }

  openViewMapBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return CustomMapViewBottomSheet();
        // return CustomEventDetailsBottomSheet(
        //   Languages.of(context)!.eventDetails.toUpperCase(),
        //   widget.bloc,
        // );
      },
    );
  }
}

class CustomMapViewBottomSheet extends StatefulWidget {
  CustomMapViewBottomSheet({Key? key}) : super(key: key);

  @override
  _CustomMapViewBottomSheetState createState() =>
      _CustomMapViewBottomSheetState();
}

class _CustomMapViewBottomSheetState extends State<CustomMapViewBottomSheet> {
  late BitmapDescriptor customIcon;
  late Position position;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(28.644800, 77.216721);
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  late String addressLine;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(12, 12)), 'assets/marker.png')
        .then((d) {
      customIcon = d;
    });
    getCurrentLocation();
    super.initState();
  }

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
    print(_position1);
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
        height: MediaQuery.of(context).size.height * 0.82,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 16),
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

  // Widget tapButton(Function onTap, IconData icon) {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       onTap();
  //     },
  //     mini: true,
  //     materialTapTargetSize: MaterialTapTargetSize.padded,
  //     backgroundColor: Color(0xFF188D3D),
  //     child: Icon(
  //       icon,
  //     ),
  //   );
  // }
}
