import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:languages/language_english.dart';
import 'package:origa/models/location_converter.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/customer_not_met_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/invalid_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/map_utils.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen(
      {Key? key, required this.bloc, required this.index, this.addressModel})
      : super(key: key);
  final CaseDetailsBloc bloc;
  final int index;
  final dynamic addressModel;

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  bool isSubmitFirst = true;
  bool isSubmitSecond = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
    widget.bloc.selectedAddressModel = widget.addressModel;
    debugPrint('Selected address model -> ${widget.bloc.selectedAddressModel}');
    // Get Initial address health status based on selected tab customer met / customer not met / invalid
    widget.bloc.add(UpdateHealthStatusEvent(context,
        selectedHealthIndex: widget.index,
        tabIndex: _controller.index,
        currentHealth: widget
            .bloc.caseDetailsAPIValue.addressDetails![widget.index]['health']));
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
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
          final UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue
                    .addressDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue
                    .addressDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue
                    .addressDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue
                        .addressDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (BuildContext context, CaseDetailsState state) {
          bool showVisit = false;
          String? key = Singleton
              .instance.contractorInformations?.googleMapsApiKey;
          if (key?.isEmpty == false) {
            showVisit = true;
          }
          return MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            removeTop: true,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: DefaultTabController(
                length: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorResource.colorFFFFFF,
                      boxShadow: <BoxShadow>[
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
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 26, 22, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomText(
                                  widget.bloc.caseDetailsAPIValue
                                      .addressDetails![widget.index]['cType']
                                      .toString()
                                      .toUpperCase(),
                                  fontWeight: FontWeight.w700,
                                  color: ColorResource.color23375A,
                                ),
                                Wrap(
                                  spacing: 27,
                                  children: <Widget>[
                                    ShowHealthStatus.healthStatus(widget
                                            .bloc
                                            .caseDetailsAPIValue
                                            .addressDetails![widget.index]
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
                                  widget.bloc.caseDetailsAPIValue
                                      .addressDetails![widget.index]['value']
                                      .toString(),
                                  color: ColorResource.color23375A,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (ConnectivityResult.none !=
                                          await Connectivity()
                                              .checkConnectivity()) {
                                        Position? currentLocation;
                                        await MapUtils.getCurrentLocation(
                                                context)
                                            .then((Position value) {
                                          setState(() {
                                            currentLocation = value;
                                          });
                                        });
                                        final Northeast? destinationLocation =
                                            await MapUtils
                                                .convertAddressToLarlng(
                                          address: widget
                                                  .bloc
                                                  .caseDetailsAPIValue
                                                  .addressDetails![widget.index]
                                              ['value'],
                                          context: context,
                                        );
                                        if (destinationLocation != null) {
                                          await MapUtils.openMap(
                                              startLatitude:
                                                  currentLocation!.latitude,
                                              startLongitude:
                                                  currentLocation!.longitude,
                                              destinationLatitude:
                                                  destinationLocation.lat ??
                                                      0.0,
                                              destinationLongitude:
                                                  destinationLocation.lng ??
                                                      0.0);
                                        }
                                      } else {
                                        AppUtils.noInternetSnackbar(context);
                                      }
                                    },
                                    child: showVisit
                                        ? SizedBox(
                                            width: 10,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color:
                                                      ColorResource.colorBEC4CF,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              75.0))),
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        ColorResource
                                                            .color23375A,
                                                    radius: 20,
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        ImageResource.direction,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  CustomText(
                                                    LanguageEn()
                                                        .viewMap
                                                        .toUpperCase(),
                                                    lineHeight: 1,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color23375A,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                                // const SizedBox(width: 30),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 10,
                                    maxWidth: 30,
                                  ),
                                ),
                                // ConstrainedBox(
                                //   constraints: const BoxConstraints(
                                //     minWidth: 45,
                                //   ),
                                //   child: Container(
                                //     height: 45,
                                //     padding: const EdgeInsets.symmetric(
                                //       horizontal: 5,
                                //     ),
                                //     decoration: BoxDecoration(
                                //         color: ColorResource.colorFFFFFF,
                                //         border: Border.all(
                                //             color: ColorResource.color23375A,
                                //             width: 0.5),
                                //         borderRadius: const BorderRadius.all(
                                //           Radius.circular(5.0),
                                //         )),
                                //     child: Center(
                                //       child: CustomText(
                                //         LanguageEn().eventDetails,
                                //         fontSize: FontSize.twelve,
                                //         color: ColorResource.color23375A,
                                //         lineHeight: 1,
                                //         fontWeight: FontWeight.w700,
                                //         fontStyle: FontStyle.normal,
                                //       ),
                                //     ),
                                //   ),
                                // )
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: CustomButton(
                                    null,
                                    isTrailing: true,
                                    isRemoveExtraPadding: true,
                                    leadingWidget: CustomText(
                                      LanguageEn().eventDetails,
                                      fontSize: FontSize.twelve,
                                      color: ColorResource.color23375A,
                                      lineHeight: 1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    onTap: () => widget.bloc.add(
                                        EventDetailsEvent(
                                            Constants.eventDetails,
                                            widget.bloc.caseDetailsAPIValue
                                                .callDetails,
                                            false)),
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
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
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
                          onTap: (int index) {
                            // change address health status based on selected tab customer met / customer not met / invalid
                            widget.bloc.add(UpdateHealthStatusEvent(context,
                                selectedHealthIndex: widget.index,
                                tabIndex: index,
                                currentHealth: widget.bloc.caseDetailsAPIValue
                                    .addressDetails![widget.index]['health']));

                            widget.bloc
                                .addressCustomerNotMetNextActionDateFocusNode
                                .unfocus();
                            widget.bloc.addressCustomerNotMetRemarksFocusNode
                                .unfocus();
                            widget.bloc.addressInvalidRemarksFocusNode
                                .unfocus();
                          },
                          tabs: <Widget>[
                            Tab(text: LanguageEn().customerMet),
                            Tab(text: LanguageEn().customerNotMet),
                            Tab(text: LanguageEn().invalid)
                          ],
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Column(children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                child: TabBarView(
                                  controller: _controller,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: <Widget>[
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
                        boxShadow: <BoxShadow>[
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
                          children: <Widget>[
                            SizedBox(
                              width: 190,
                              child: CustomButton(
                                LanguageEn().done.toUpperCase(),
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
                        boxShadow: <BoxShadow>[
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
                          children: <Widget>[
                            Expanded(
                              child: CustomCancelButton.cancelButton(context),
                            ),
                            SizedBox(
                              width: 191,
                              child: _controller.index == 1
                                  ? CustomButton(
                                      isSubmitFirst
                                          ? LanguageEn().submit.toUpperCase()
                                          : null,
                                      isLeading: !isSubmitFirst,
                                      trailingWidget: CustomLoadingWidget(
                                        gradientColors: <Color>[
                                          ColorResource.colorFFFFFF,
                                          ColorResource.colorFFFFFF
                                              .withOpacity(0.7),
                                        ],
                                      ),
                                      onTap: isSubmitFirst
                                          ? () async {
                                              if (await AppUtils
                                                  .checkGPSConnection(
                                                      context)) {
                                                if (await AppUtils
                                                    .checkLocationPermission(
                                                        context)) {
                                                  if (widget.bloc
                                                          .isRecordCustomerNotMet ==
                                                      Constants.process) {
                                                    AppUtils.showToast(
                                                        'Stop the Record then Submit');
                                                  } else if (widget.bloc
                                                          .isRecordCustomerNotMet ==
                                                      Constants.stop) {
                                                    AppUtils.showToast(
                                                        'Please wait audio is converting');
                                                  } else {
                                                    if (widget.bloc
                                                            .isRecordCustomerNotMet ==
                                                        Constants.submit) {
                                                      setState(() => widget
                                                              .bloc
                                                              .addressCustomerNotMetRemarksController
                                                              .text =
                                                          widget.bloc
                                                              .translateTextCustomerNotMet);
                                                      setState(() => widget.bloc
                                                              .isTranslateCustomerNotMet =
                                                          false);
                                                    }
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
                                                        AppUtils.showToast(
                                                          LanguageEn()
                                                              .pleaseSelectOptions,
                                                        );
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          : () {},
                                      cardShape: 5,
                                    )
                                  : CustomButton(
                                      isSubmitSecond
                                          ? LanguageEn().submit.toUpperCase()
                                          : null,
                                      isLeading: !isSubmitSecond,
                                      trailingWidget: CustomLoadingWidget(
                                        gradientColors: <Color>[
                                          ColorResource.colorFFFFFF,
                                          ColorResource.colorFFFFFF
                                              .withOpacity(0.7),
                                        ],
                                      ),
                                      onTap: isSubmitSecond
                                          ? () async {
                                              if (await AppUtils
                                                  .checkGPSConnection(
                                                      context)) {
                                                if (await AppUtils
                                                    .checkLocationPermission(
                                                        context)) {
                                                  if (widget.bloc
                                                          .isRecordAddressInvaild ==
                                                      Constants.process) {
                                                    AppUtils.showToast(
                                                        'Stop the Record then Submit');
                                                  } else if (widget.bloc
                                                          .isRecordAddressInvaild ==
                                                      Constants.stop) {
                                                    AppUtils.showToast(
                                                        'Please wait audio is converting');
                                                  } else {
                                                    if (widget.bloc
                                                            .isRecordAddressInvaild ==
                                                        Constants.submit) {
                                                      setState(() => widget
                                                              .bloc
                                                              .addressInvalidRemarksController
                                                              .text =
                                                          widget.bloc
                                                              .translateTextAddressInvalid);
                                                      setState(() => widget.bloc
                                                              .isTranslateAddressInvalid =
                                                          false);
                                                    }
                                                    widget.bloc.add(
                                                        ClickAddressInvalidButtonEvent(
                                                            context));
                                                  }
                                                }
                                              }
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
