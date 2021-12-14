import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/models/home_address_post_model/home_address_post_model.dart';
import 'package:origa/models/profile_navigation_button_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/allocation/map_view.dart';
import 'package:origa/screen/message_screen/message.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/screen/profile_screen.dart/language_bottom_sheet_screen.dart';
import 'package:origa/screen/profile_screen.dart/notification_bottom_sheet_screen.dart';
import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc bloc;
  File? image;
  String addressValue = '_';

  @override
  void initState() {
    bloc = ProfileBloc()..add(ProfileInitialEvent(context));

    super.initState();
  }

  Future pickImage(
      ImageSource source, BuildContext cameraDialogueContext) async {
    Navigator.pop(cameraDialogueContext);
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final getProfileImage = File(image.path);
        setState(() {
          this.image = getProfileImage;
          bloc.add(PostProfileImageEvent(postValue: getProfileImage.path));
        });
      } else {
        AppUtils.showToast(StringResource.canceled,
            gravity: ToastGravity.CENTER);
      }
      // if (image == null) return;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    List<ProfileNavigation> profileNavigationList = [
      ProfileNavigation(
          title: Languages.of(context)!.notification,
          notificationCount: 3,
          onTap: () {
            bloc.add(ClickNotificationEvent());
          }),
      ProfileNavigation(
          title: Languages.of(context)!.selectLanguage,
          onTap: () {
            bloc.add(ClickChangeLaunguageEvent());
          }),
      ProfileNavigation(
          title: Languages.of(context)!.changePassword,
          onTap: () {
            bloc.add(ClickChangePassswordEvent());
          })
    ];
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is PostDataApiSuccessState) {
          AppUtils.topSnackBar(context, StringResource.profileImageChanged);
        }
        if (state is ClickNotificationState) {
          notificationShowBottomSheet(context);
        }
        if (state is ClickChangeLaunguageState) {
          languageBottomSheet();
        }
        if (state is ClickMessageState) {
          messageShowBottomSheet();
        }
        if (state is ChangeProfileImageState) {
          profileImageShowBottomSheet();
        }
        if (state is NoInternetState) {
          AppUtils.noInternetSnackbar(context);
        }
        if (state is ClickChangePasswordState) {
          changePasswordBottomSheet(context);
        }
        if (state is ClickMarkAsHomeState) {
          markAsHomeShowBottomSheet(context);
        }
        if (state is LoginState) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.loginScreen, (route) => false);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              backgroundColor: ColorResource.colorF7F8FA,
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 9, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorResource.colorFFFFFF,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResource.color000000.withOpacity(0.2),
                                blurRadius: 2.0,
                                offset: const Offset(
                                    1.0, 1.0), // shadow direction: bottom right
                              )
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 19.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  // Image.asset(
                                  //     bloc.offlineProfileValue.profileImgUrl!),
                                  GestureDetector(
                                    onTap: () =>
                                        bloc.add(ChangeProfileImageEvent()),
                                    child: image == null
                                        ? Container(
                                            child: SvgPicture.asset(
                                                ImageResource
                                                    .profileImagePicker),
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: ColorResource.color23375A,
                                              borderRadius:
                                                  BorderRadius.circular(52.5),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                FileImage(File(image!.path))),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.013),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        bloc.offlineProfileValue.type
                                            .toString(),
                                        fontSize: FontSize.eighteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color101010,
                                      ),
                                      const SizedBox(height: 11),
                                      CustomText(
                                        bloc.offlineProfileValue.name
                                            .toString(),
                                        fontSize: FontSize.sixteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: ColorResource.color101010,
                                      ),
                                      CustomText(
                                        bloc.offlineProfileValue.defMobileNumber
                                            .toString(),
                                        fontSize: FontSize.sixteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color101010,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    Languages.of(context)!
                                        .homeAddress
                                        .toUpperCase(),
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color101010,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        bloc.add(ClickMarkAsHomeEvent()),
                                    child: SizedBox(
                                      child: CustomText(
                                        Languages.of(context)!.markAsHome,
                                        fontSize: FontSize.twelve,
                                        isUnderLine: true,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color101010,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: const BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16.0,
                                  ),
                                  child: CustomText(
                                    (bloc.offlineProfileValue.address
                                                ?.last['cType'] ==
                                            'address')
                                        ? bloc.offlineProfileValue.address
                                            ?.last['value']
                                        : addressValue,
                                    fontSize: FontSize.fourteen,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color484848,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profileNavigationList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: profileNavigationList[index].onTap,
                                      // onTap: () => bloc
                                      //     .profileNavigationList[index].onTap,
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: const BoxDecoration(
                                            color: ColorResource.colorF8F9FB,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 21, vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                child: Row(
                                                  children: [
                                                    CustomText(
                                                      profileNavigationList[
                                                              index]
                                                          .title
                                                          .toUpperCase(),
                                                      lineHeight: 1,
                                                      fontSize:
                                                          FontSize.sixteen,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: ColorResource
                                                          .color23375A,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    profileNavigationList[index]
                                                                .notificationCount ==
                                                            null
                                                        ? const SizedBox()
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                ColorResource
                                                                    .color23375A,
                                                            radius: 13,
                                                            child: Center(
                                                              child: CustomText(
                                                                  profileNavigationList[
                                                                          index]
                                                                      .notificationCount
                                                                      .toString(),
                                                                  lineHeight: 1,
                                                                  fontSize:
                                                                      FontSize
                                                                          .twelve,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: ColorResource
                                                                      .colorFFFFFF),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  ImageResource.forwardArrow)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      GestureDetector(
                        onTap: () => bloc.add(LoginEvent()),
                        child: Container(
                          width: 125,
                          height: 40,
                          decoration: BoxDecoration(
                              color: ColorResource.colorFFFFFF,
                              border: Border.all(
                                  color: ColorResource.color23375A, width: 0.5),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(75.0))),
                          child: Center(
                            child: CustomText(
                              Languages.of(context)!.logout.toUpperCase(),
                              // onTap: () {
                              //   bloc.add(LoginEvent());
                              // },
                              fontSize: FontSize.twelve,
                              color: ColorResource.color23375A,
                              fontWeight: FontWeight.w700,
                              lineHeight: 1,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                width: double.infinity,
                color: ColorResource.colorFFFFFF,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                          Languages.of(context)!.message,
                          onTap: () => bloc.add(ClickMessageEvent()),
                          fontSize: FontSize.sixteen,
                          cardShape: 5,
                          isTrailing: true,
                          leadingWidget: const CircleAvatar(
                            radius: 13,
                            backgroundColor: ColorResource.colorFFFFFF,
                            child: CustomText('2',
                                fontSize: FontSize.twelve,
                                lineHeight: 1,
                                color: ColorResource.colorEA6D48,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  profileImageShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                WillPopScope(
                  onWillPop: () async => false,
                  child: SizedBox(
                    height: 270.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                Languages.of(context)!
                                    .addAProfilePhoto
                                    .toUpperCase(),
                                color: ColorResource.color23375A,
                                fontSize: FontSize.fourteen,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(ImageResource.close))
                            ],
                          ),
                          const SizedBox(height: 60),
                          CustomButton(
                            Languages.of(context)!.captureImage.toUpperCase(),
                            cardShape: 75.0,
                            textColor: ColorResource.color23375A,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w700,
                            padding: 15.0,
                            borderColor: ColorResource.colorBEC4CF,
                            buttonBackgroundColor: ColorResource.colorBEC4CF,
                            isLeading: true,
                            onTap: () => pickImage(ImageSource.camera, context),
                            // onTap: () => pickImage(source, cameraDialogueContext)
                            trailingWidget:
                                SvgPicture.asset(ImageResource.captureImage),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            Languages.of(context)!.uploadPhoto,
                            textColor: ColorResource.color23375A,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w700,
                            padding: 15.0,
                            cardShape: 75.0,
                            onTap: () =>
                                pickImage(ImageSource.gallery, context),
                            borderColor: ColorResource.colorBEC4CF,
                            buttonBackgroundColor: ColorResource.colorBEC4CF,
                            isLeading: true,
                            trailingWidget:
                                SvgPicture.asset(ImageResource.uploadPhoto),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }

  changePasswordBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: buildContext,
      backgroundColor: ColorResource.colorF8F9FB,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const ResetPasswordScreen();
      },
    );
  }

  languageBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                LanguageBottomSheetScreen(bloc: bloc)));
  }

  messageShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                WillPopScope(
                  onWillPop: () async => false,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.86,
                      child: const MessageChatRoomScreen()),
                )));
  }

  notificationShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                NotificationBottomSheetScreen(bloc: bloc)));
  }

  markAsHomeShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => LayoutBuilder(
            builder: (BuildContext buildContext, BoxConstraints settate) =>
                MarkAsHomeBottomSheet(
                  onClose: (value) {
                    setState(() {
                      addressValue = value;
                    });
                  },
                )));
  }
}

class MarkAsHomeBottomSheet extends StatefulWidget {
  MarkAsHomeBottomSheet({Key? key, this.onClose}) : super(key: key);
  final Function? onClose;

  @override
  _MarkAsHomeBottomSheetState createState() => _MarkAsHomeBottomSheetState();
}

class _MarkAsHomeBottomSheetState extends State<MarkAsHomeBottomSheet> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(28.644800, 77.216721);
  late Position position;
  Set<Marker> _markers = {};
  LatLng tabLatLng = LatLng(0.0, 0.0);
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
                  title: Languages.of(context)!.markAsHome.toUpperCase(),
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
