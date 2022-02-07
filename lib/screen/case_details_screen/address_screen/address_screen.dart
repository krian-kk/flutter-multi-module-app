import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/location_converter.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_not_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/invalid_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/map_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class AddressScreen extends StatefulWidget {
  final CaseDetailsBloc bloc;
  final int index;
  const AddressScreen({Key? key, required this.bloc, required this.index})
      : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  bool isSubmitFirst = true;
  bool isSubmitSecond = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
    print("selected tab.....r index");
    // Get Initial address health status based on selected tab customer met / customer not met / invalid
    widget.bloc.add(UpdateHealthStatusEvent(context,
        selectedHealthIndex: widget.index,
        tabIndex: _controller.index,
        currentHealth: widget.bloc.caseDetailsAPIValue.result
            ?.addressDetails![widget.index]['health']));
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {
        print("selected tab index");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<CustomerMetNotButtonModel> customerMetNotButtonList = [
    //   CustomerMetNotButtonModel(Languages.of(context)!.leftMessage),
    //   CustomerMetNotButtonModel(Languages.of(context)!.doorLocked),
    //   CustomerMetNotButtonModel(Languages.of(context)!.entryRestricted),
    // ];
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is DisableCustomerNotMetBtnState) {
          setState(() => isSubmitFirst = false);
        }
        if (state is EnableCustomerNotMetBtnState) {
          setState(() => isSubmitFirst = true);
        }
        if (state is DisableAddressInvalidBtnState) {
          setState(() => isSubmitSecond = false);
        }
        if (state is EnableAddressInvalidBtnState) {
          setState(() => isSubmitSecond = true);
        }
        if (state is UpdateHealthStatusState) {
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            removeTop: true,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              // backgroundColor: ColorResource.colorF7F8FA,
              body: DefaultTabController(
                length: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorResource.colorFFFFFF,
                      boxShadow: [
                        BoxShadow(
                          color: ColorResource.colorCACACA.withOpacity(.25),
                          blurRadius: 20.0,
                          offset: const Offset(1.0, 1.0),
                        ),
                      ],
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30))),
                  width: double.infinity,
                  child: Column(
                    children: [
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
                                  widget
                                          .bloc
                                          .caseDetailsAPIValue
                                          .result
                                          ?.addressDetails![widget.index]
                                              ['cType']
                                          .toString()
                                          .toUpperCase() ??
                                      '_',
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                  color: ColorResource.color23375A,
                                ),
                                Wrap(
                                  spacing: 27,
                                  children: [
                                    // SvgPicture.asset(
                                    //     ImageResource.activePerson),
                                    ShowHealthStatus.healthStatus(widget
                                            .bloc
                                            .caseDetailsAPIValue
                                            .result
                                            ?.addressDetails![widget.index]
                                        ['health']),
                                    InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: SvgPicture.asset(
                                              ImageResource.close),
                                        ))
                                  ],
                                )
                              ],
                            ),
                            Flexible(
                              child: SizedBox(
                                width: 255,
                                child: CustomText(
                                  widget
                                          .bloc
                                          .caseDetailsAPIValue
                                          .result
                                          ?.addressDetails![widget.index]
                                              ['value']
                                          .toString()
                                          .toUpperCase() ??
                                      '_',
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
                                  onTap: () async {
                                    Position? currentLocation;
                                    await MapUtils.getCurrentLocation()
                                        .then((value) {
                                      setState(() {
                                        currentLocation = value;
                                      });
                                    });
                                    Northeast? destinationLocation =
                                        await MapUtils.convertAddressToLarlng(
                                            address: widget
                                                    .bloc
                                                    .caseDetailsAPIValue
                                                    .result!
                                                    .addressDetails![
                                                widget.index]['value']);
                                    if (destinationLocation != null) {
                                      MapUtils.openMap(
                                          startLatitude:
                                              currentLocation!.latitude,
                                          startLongitude:
                                              currentLocation!.longitude,
                                          destinationLatitude:
                                              destinationLocation.lat ?? 0.0,
                                          destinationLongitude:
                                              destinationLocation.lng ?? 0.0);
                                    }
                                  },
                                  // onTap: () => widget.bloc.add(
                                  //     ClickOpenBottomSheetEvent(
                                  //         Constants.viewMap,
                                  //         widget.bloc.caseDetailsAPIValue.result
                                  //             ?.callDetails,
                                  //         false)),
                                  child: SizedBox(
                                      width: 10,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: ColorResource.colorBEC4CF,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(75.0))),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    ColorResource.color23375A,
                                                radius: 20,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    ImageResource.direction,
                                                  ),
                                                ),
                                              ),
                                              // Image.asset(
                                              //     ImageResource.direction),
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.21,
                                                child: FittedBox(
                                                  child: CustomText(
                                                    Languages.of(context)!
                                                        .viewMap
                                                        .toUpperCase(),
                                                    fontSize: FontSize.fourteen,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))),
                                )),
                                const SizedBox(width: 40),
                                Expanded(
                                    child: SizedBox(
                                  height: 47,
                                  child: CustomButton(
                                    Languages.of(context)!.eventDetails,
                                    onTap: () => widget.bloc.add(
                                      ClickOpenBottomSheetEvent(
                                          Constants.eventDetails,
                                          widget.bloc.caseDetailsAPIValue.result
                                              ?.addressDetails,
                                          false),
                                    ),
                                    textColor: ColorResource.color23375A,
                                    borderColor: ColorResource.color23375A,
                                    buttonBackgroundColor:
                                        ColorResource.colorFFFFFF,
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorResource.colorD8D8D8))),
                        child: TabBar(
                          isScrollable: true,
                          controller: _controller,
                          indicatorColor: ColorResource.colorD5344C,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: ColorResource.color23375A,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal),
                          indicatorWeight: 5.0,
                          labelColor: ColorResource.color23375A,
                          unselectedLabelColor: ColorResource.colorC4C4C4,
                          onTap: (index) {
                            // change address health status based on selected tab customer met / customer not met / invalid
                            widget.bloc.add(UpdateHealthStatusEvent(context,
                                selectedHealthIndex: widget.index,
                                tabIndex: index,
                                currentHealth: widget
                                    .bloc
                                    .caseDetailsAPIValue
                                    .result
                                    ?.addressDetails![widget.index]['health']));

                            widget.bloc
                                .addressCustomerNotMetNextActionDateFocusNode
                                .unfocus();
                            widget.bloc.addressCustomerNotMetRemarksFocusNode
                                .unfocus();
                            widget.bloc.addressInvalidRemarksFocusNode
                                .unfocus();
                          },
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
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                child: TabBarView(
                                  controller: _controller,
                                  physics: const NeverScrollableScrollPhysics(),
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
                          BoxShadow(
                            color: ColorResource.color000000.withOpacity(.25),
                            blurRadius: 2.0,
                            offset: const Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 85, vertical: 11.0),
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
                          BoxShadow(
                            color: ColorResource.color000000.withOpacity(.25),
                            blurRadius: 2.0,
                            offset: const Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: SizedBox(
                                  width: 95,
                                  child: Center(
                                      child: CustomText(
                                    Languages.of(context)!.cancel.toUpperCase(),
                                    color: ColorResource.colorEA6D48,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize: FontSize.sixteen,
                                  ))),
                            ),
                            const SizedBox(width: 25),
                            SizedBox(
                              width: 191,
                              child: _controller.index == 1
                                  ? CustomButton(
                                      isSubmitFirst
                                          ? Languages.of(context)!
                                              .submit
                                              .toUpperCase()
                                          : null,
                                      isLeading: !isSubmitFirst,
                                      trailingWidget: CustomLoadingWidget(
                                        gradientColors: [
                                          ColorResource.colorFFFFFF,
                                          ColorResource.colorFFFFFF
                                              .withOpacity(0.7),
                                        ],
                                      ),
                                      // isEnabled: (bloc.selectedUnreadableClip == ''),
                                      fontSize: FontSize.sixteen,
                                      fontWeight: FontWeight.w600,

                                      onTap: isSubmitFirst
                                          ? () {
                                              if (widget
                                                  .bloc
                                                  .addressCustomerNotMetFormKey
                                                  .currentState!
                                                  .validate()) {
                                                if (widget.bloc
                                                        .addressSelectedCustomerNotMetClip !=
                                                    '') {
                                                  widget.bloc.add(
                                                      ClickCustomerNotMetButtonEvent(
                                                          context));
                                                } else {
                                                  AppUtils.showToast(Constants
                                                      .pleaseSelectOptions);
                                                }
                                              } else {}
                                            }
                                          : () {},
                                      cardShape: 5,
                                    )
                                  : CustomButton(
                                      isSubmitSecond
                                          ? Languages.of(context)!
                                              .submit
                                              .toUpperCase()
                                          : null,
                                      isLeading: !isSubmitSecond,
                                      trailingWidget: CustomLoadingWidget(
                                        gradientColors: [
                                          ColorResource.colorFFFFFF,
                                          ColorResource.colorFFFFFF
                                              .withOpacity(0.7),
                                        ],
                                      ),
                                      // isEnabled: (bloc.selectedInvalidClip != ''),
                                      fontSize: FontSize.sixteen,
                                      fontWeight: FontWeight.w600,
                                      onTap: isSubmitSecond
                                          ? () {
                                              widget.bloc.add(
                                                  ClickAddressInvalidButtonEvent(
                                                      context));
                                            }
                                          : () {},
                                      cardShape: 5,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class CustomMapViewBottomSheet extends StatefulWidget {
  const CustomMapViewBottomSheet({Key? key}) : super(key: key);

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
  late String addressLine;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)), 'assets/marker.png')
        .then((d) {
      customIcon = d;
    });
    getCurrentLocation();
    super.initState();
  }

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.toString() == PermissionStatus.granted.toString()) {
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
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('current location'),
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 5, 0),
                child: BottomSheetAppbar(
                  title: Languages.of(context)!.mapView,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
              ),
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
                ),
              ),
            ],
          );
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
