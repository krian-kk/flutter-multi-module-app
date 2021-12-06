import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/address_invalid_post_model/address_invalid_post_model.dart';
import 'package:origa/models/customer_not_met_post_model/customer_not_met_post_model.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_not_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/invalid_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
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
  final int index;
  const AddressScreen({Key? key, required this.bloc, required this.index})
      : super(key: key);

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
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is ClickViewMapState) {
          openViewMapBottomSheet(context);
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
                                  widget.bloc.offlineCaseDetailsValue
                                      .addressDetails![widget.index]['cType']
                                      .toString()
                                      .toUpperCase(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                  color: ColorResource.color23375A,
                                ),
                                Wrap(
                                  spacing: 27,
                                  children: [
                                    SvgPicture.asset(
                                        ImageResource.activePerson),
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
                                  widget.bloc.offlineCaseDetailsValue
                                      .addressDetails![widget.index]['value']
                                      .toString()
                                      .toUpperCase(),
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
                                  onTap: () =>
                                      widget.bloc.add(ClickViewMapEvent()),
                                  child: SizedBox(
                                      width: 10,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: ColorResource.colorBEC4CF,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(75.0))),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  ImageResource.direction),
                                              const SizedBox(width: 10),
                                              const CustomText(
                                                StringResource.viewMap,
                                                fontSize: FontSize.fourteen,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color23375A,
                                              )
                                            ],
                                          ))),
                                )),
                                const SizedBox(width: 40),
                                Expanded(
                                    child: CustomButton(
                                  Languages.of(context)!.eventDetails,
                                  onTap: () => widget.bloc.add(
                                      ClickOpenBottomSheetEvent(
                                          StringResource.eventDetails)),
                                  textColor: ColorResource.color23375A,
                                  borderColor: ColorResource.color23375A,
                                  buttonBackgroundColor:
                                      ColorResource.colorFFFFFF,
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
                                      Languages.of(context)!
                                          .submit
                                          .toUpperCase(),
                                      // isEnabled: (bloc.selectedUnreadableClip == ''),
                                      fontSize: FontSize.sixteen,
                                      fontWeight: FontWeight.w600,

                                      onTap: () {
                                        if (widget
                                                .bloc
                                                .addressCustomerNotMetFormKey
                                                .currentState!
                                                .validate() &&
                                            widget.bloc
                                                    .addressSelectedCustomerNotMetClip !=
                                                '') {
                                          if (widget.bloc
                                                  .addressSelectedCustomerNotMetClip ==
                                              Languages.of(context)!
                                                  .leftMessage) {
                                            customerNotMetButtonClick(
                                              'Left Message',
                                              widget.bloc.caseId.toString(),
                                              'TELEVT007',
                                              HttpUrl.leftMessageUrl(
                                                'leftMessage',
                                                'FIELDAGENT',
                                              ),
                                              'PTP',
                                              {},
                                            );
                                          } else if (widget.bloc
                                                  .addressSelectedCustomerNotMetClip ==
                                              Languages.of(context)!
                                                  .doorLocked) {
                                            customerNotMetButtonClick(
                                              'Door Locked',
                                              widget.bloc.caseId.toString(),
                                              'TELEVT007',
                                              HttpUrl.doorLockedUrl(
                                                  'doorLocked', 'FIELDAGENT'),
                                              'NEW',
                                              [],
                                            );
                                          } else if (widget.bloc
                                                  .addressSelectedCustomerNotMetClip ==
                                              Languages.of(context)!
                                                  .entryRestricted) {
                                            customerNotMetButtonClick(
                                              'Entry Restricted',
                                              widget.bloc.caseId.toString(),
                                              'TELEVT007',
                                              HttpUrl.entryRestrictedUrl(
                                                  'entryRestricted',
                                                  'FIELDAGENT'),
                                              'PTP',
                                              [],
                                            );
                                          }
                                        } else {}
                                      },
                                      cardShape: 5,
                                    )
                                  : CustomButton(
                                      Languages.of(context)!
                                          .submit
                                          .toUpperCase(),
                                      // isEnabled: (bloc.selectedInvalidClip != ''),
                                      fontSize: FontSize.sixteen,
                                      fontWeight: FontWeight.w600,
                                      onTap: () {
                                        if (widget.bloc.addressInvalidFormKey
                                                .currentState!
                                                .validate() &&
                                            widget.bloc
                                                    .addressSelectedInvalidClip !=
                                                '') {
                                          if (widget.bloc
                                                  .addressSelectedInvalidClip ==
                                              Languages.of(context)!
                                                  .wrongAddress) {
                                            invalidButtonClick(
                                              'Wrong Address',
                                              widget.bloc.caseId.toString(),
                                              'TELEVT008',
                                              HttpUrl.wrongAddressUrl(
                                                'invalidAddress',
                                                'FIELDAGENT',
                                              ),
                                              'PTP',
                                            );
                                          } else if (widget.bloc
                                                  .addressSelectedInvalidClip ==
                                              Languages.of(context)!.shifted) {
                                            invalidButtonClick(
                                                'Shifted',
                                                widget.bloc.caseId.toString(),
                                                'TELEVT008',
                                                HttpUrl.shiftedUrl(
                                                    'shifted', 'FIELDAGENT'),
                                                'REVIEW');
                                          } else if (widget.bloc
                                                  .addressSelectedInvalidClip ==
                                              Languages.of(context)!
                                                  .addressNotFound) {
                                            invalidButtonClick(
                                              'Address Not Found',
                                              widget.bloc.caseId.toString(),
                                              'TELEVT008',
                                              HttpUrl.addressNotFoundUrl(
                                                'addressNotFound',
                                                'FIELDAGENT',
                                              ),
                                              'PTP',
                                            );
                                          }
                                        } else {}
                                      },
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

  invalidButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
    String followUpPriority,
  ) async {
    var requestBodyData = AddressInvalidPostModel(
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        eventAttr: EventAttr(
            remarks: widget.bloc.addressInvalidRemarksController.text,
            followUpPriority: followUpPriority,
            agentLocation: AgentLocation()),
        contact: []);
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );

    if (await postResult['success']) {
      setState(() {
        widget.bloc.addressInvalidRemarksController.text = '';
        widget.bloc.addressSelectedInvalidClip = '';
      });
      Navigator.pop(context);
    }
  }

  customerNotMetButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
    String followUpPriority,
    dynamic contact,
  ) async {
    var requestBodyData = CustomerNotMetPostModel(
        eventType: eventType,
        caseId: caseId,
        eventCode: eventCode,
        contact: contact,
        eventAttr: CustomerNotMetEventAttr(
            remarks: widget.bloc.addressCustomerNotMetRemarksController.text,
            followUpPriority: followUpPriority,
            nextActionDate:
                widget.bloc.addressCustomerNotMetNextActionDateController.text,
            agentLocation: CustomerNotMetAgentLocation()));

    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );

    if (await postResult['success']) {
      setState(() {
        widget.bloc.addressCustomerNotMetNextActionDateController.text = '';
        widget.bloc.addressCustomerNotMetRemarksController.text = '';
        widget.bloc.addressSelectedCustomerNotMetClip = '';
      });
      Navigator.pop(context);
    }
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
        return const CustomMapViewBottomSheet();
        // return CustomEventDetailsBottomSheet(
        //   Languages.of(context)!.eventDetails.toUpperCase(),
        //   widget.bloc,
        // );
      },
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
