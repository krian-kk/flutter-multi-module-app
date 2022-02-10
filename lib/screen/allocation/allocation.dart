import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/are_you_at_office_model.dart/are_you_at_office_model.dart';
import 'package:origa/models/buildroute_data.dart';
import 'package:origa/models/call_customer_model/call_customer_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/return_value_model.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/models/update_staredcase_model.dart';
import 'package:origa/models/voice_agency_detail_model/voice_agency_detail_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/allocation/auto_calling_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/phone_screen/phone_screen.dart';
import 'package:origa/screen/map_screen/bloc/map_bloc.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/allocation_bloc.dart';
import 'custom_card_list.dart';

class AllocationScreen extends StatefulWidget {
  const AllocationScreen({Key? key}) : super(key: key);

  // AuthenticationBloc authenticationBloc;
  // AllocationScreen(this.authenticationBloc);

  @override
  _AllocationScreenState createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
  late AllocationBloc bloc;
  String? currentAddress;
  bool isCaseDetailLoading = false;
  late MapBloc mapBloc;
  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );
  List<Result> resultList = [];
  String? searchBasedOnValue;
  String version = "";
  late Timer _timer;

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc = AllocationBloc()..add(AllocationInitialEvent(context));
    _controller = ScrollController()..addListener(_loadMore);
    getCurrentLocation();
  }

  //get current location lat, alng and address
  void getCurrentLocation() async {
    Position result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      position = result;
    });
    // print('position------> ${position.heading}');
    // print(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(result.latitude, result.longitude);

    setState(() {
      currentAddress = placemarks.toList().first.street.toString() +
          ', ' +
          placemarks.toList().first.subLocality.toString() +
          ', ' +
          placemarks.toList().first.postalCode.toString();
      // print(currentAddress);
    });
  }

  mapView(BuildContext buildContext) {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        context: buildContext,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: ColorResource.colorFFFFFF,
        builder: (BuildContext context) {
          return MapNavigation(
            multipleLatLong: bloc.multipleLatLong,
          );
          // MapViewBottomSheetScreen(
          //   title: Languages.of(context)!.viewMap,
          //   listOfAgentLocation: bloc.priorityCaseAddressList,
          // );
        });
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
                  onWillPop: () async => true,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.86,
                    child: const SizedBox(),
                    // child: const MessageChatRoomScreen(),
                  ),
                )));
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (bloc.hasNextPage) {
        if (bloc.isShowSearchPincode) {
        } else if (bloc.isPriorityLoadMore) {
          bloc.page += 1;
          bloc.add(PriorityLoadMoreEvent());
        } else {
          bloc.page += 1;
          bloc.add(BuildRouteLoadMoreEvent());
        }
      }
    }
  }

  List<Widget> _buildFilterOptions() {
    List<Widget> widgets = [];
    bloc.selectOptions.asMap().forEach((index, element) {
      widgets.add(_buildFilterWidget(index, element));
    });
    return widgets;
  }

  Widget _buildFilterWidget(int index, String element) {
    return InkWell(
      onTap: () {
        setState(() {
          bloc.selectedOption = index;
        });
        switch (index) {
          case 0:
            setState(() {
              bloc.showFilterDistance = false;
              bloc.add(TapPriorityEvent());
            });
            break;
          case 1:
            if (bloc.userType == Constants.fieldagent) {
              setState(() {
                bloc.add(TapBuildRouteEvent(
                    paramValues: BuildRouteDataModel(
                        lat: position.latitude.toString(),
                        long: position.longitude.toString(),
                        maxDistMeters: Constants.allDisMeters)));
                bloc.showFilterDistance = true;
              });
            } else {
              bloc.add(ShowAutoCallingEvent());
            }
            break;
          case 2:
            bloc.add(MapViewEvent(
                paramValues: BuildRouteDataModel(
                    lat: position.latitude.toString(),
                    long: position.longitude.toString(),
                    maxDistMeters: Constants.maxDisMeters)));
            setState(() {
              bloc.showFilterDistance = false;
            });
            break;
          default:
            setState(() {
              bloc.showFilterDistance = false;
            });
        }
        // if (option == 'Build Route') {
        //   setState(() {
        //     bloc.showFilterDistance = true;
        //   });
        // } else {
        //   setState(() {
        //     bloc.showFilterDistance = false;
        //   });
        // }
        // print(option);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
        width: 90,
        // height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: ColorResource.color23375A, width: 0.5),
          borderRadius: BorderRadius.circular(5),
          color: index == bloc.selectedOption
              ? ColorResource.color23375A
              : Colors.white,
        ),
        child: Center(
          child: CustomText(
            element,
            fontSize: FontSize.twelve,
            fontWeight: FontWeight.w700,
            color: index == bloc.selectedOption
                ? Colors.white
                : ColorResource.color000000,
          ),
        ),
      ),
    );
  }

  Widget _buildBuildRoute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 7,
        ),
        currentAddress != null
            ? Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(ImageResource.location2),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 213,
                    child: CustomText(
                      currentAddress!,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      fontSize: FontSize.twelve,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color101010,
                      isSingleLine: true,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: GestureDetector(
                      child: CustomText(
                        Languages.of(context)!.change,
                        fontSize: FontSize.twelve,
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color23375A,
                      ),
                      onTap: () {
                        getCurrentLocation();
                        // AppUtils.showToast('Change address');
                      },
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: _buildRouteFilterOptions(),
        ),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  }

  List<Widget> _buildRouteFilterOptions() {
    List<Widget> widgets = [];
    bloc.filterBuildRoute.asMap().forEach((index, element) {
      widgets.add(_buildRouteFilterWidget(index, element));
    });
    return widgets;
  }

  Widget _buildRouteFilterWidget(int index, String distance) {
    String? maxDistance;
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            maxDistance = Constants.allDisMeters;
            break;
          case 1:
            maxDistance = Constants.minDisMeters;
            break;
          case 2:
            maxDistance = Constants.maxDisMeters;
            break;
          default:
        }
        setState(() {
          bloc.selectedDistance = distance;
          bloc.add(TapBuildRouteEvent(
              paramValues: BuildRouteDataModel(
                  lat: position.latitude.toString(),
                  long: position.longitude.toString(),
                  maxDistMeters: maxDistance)));
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
        width: 93,
        // height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: ColorResource.color23375A, width: 0.5),
          borderRadius: BorderRadius.circular(85),
          color: distance == bloc.selectedDistance
              ? ColorResource.color23375A
              : Colors.white,
        ),
        child: Center(
          child: CustomText(
            distance,
            fontSize: FontSize.twelve,
            fontWeight: FontWeight.w700,
            color: distance == bloc.selectedDistance
                ? Colors.white
                : ColorResource.color000000,
          ),
        ),
      ),
    );
  }

  Future<void> phoneBottomSheet(
      BuildContext buildContext, CaseDetailsBloc bloc, int i) {
    return showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return PhoneScreen(bloc: bloc, index: i);
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<AllocationBloc, AllocationState>(
      bloc: bloc,
      listener: (BuildContext context, AllocationState state) async {
        if (state is NoInternetConnectionState) {
          AppUtils.noInternetSnackbar(context);
        }
        if (state is CaseListViewLoadingState) {
          isCaseDetailLoading = true;
        }
        if (state is MapViewState) {
          mapView(context);
          bloc.isShowSearchPincode = false;
        }
        if (state is MessageState) {
          messageShowBottomSheet();
        }
        if (state is StartCallingState) {
          setState(() {});
          if (bloc.customerCount < bloc.totalCount) {
            Map<String, dynamic> getAgencyDetailsData =
                await APIRepository.apiRequest(
                    APIRequestType.GET, HttpUrl.voiceAgencyDetailsUrl);
            if (getAgencyDetailsData[Constants.success]) {
              if (Singleton.instance.cloudTelephony!) {
                Map<String, dynamic> jsonData = getAgencyDetailsData['data'];
                AgencyDetailsModel voiceAgencyDetails =
                    AgencyDetailsModel.fromJson(jsonData);

                if (state.customerIndex! < bloc.resultList.length) {
                  List<Address> tempMobileList = [];
                  bloc.resultList[state.customerIndex!].address
                      ?.asMap()
                      .forEach((i, element) {
                    if (element.cType == 'mobile') {
                      tempMobileList.add(element);
                    }
                  });
                  if (state.phoneIndex! < tempMobileList.length) {
                    var requestBodyData = CallCustomerModel(
                      from: voiceAgencyDetails.result?.agentAgencyContact ?? '',
                      to: tempMobileList[state.phoneIndex!].value ?? '',
                      callerId: voiceAgencyDetails.result?.voiceAgencyData
                              ?.first.callerIds?.first ??
                          '0',
                      aRef: Singleton.instance.agentRef ?? '',
                      customerName: Singleton.instance.agentName ?? '',
                      service: voiceAgencyDetails
                              .result?.voiceAgencyData?.first.agencyId ??
                          '0',
                      callerServiceID: voiceAgencyDetails
                              .result?.voiceAgencyData?.first.agencyId ??
                          '0',
                      caseId: bloc.resultList[state.customerIndex!].caseId!,
                      sId: bloc.resultList[state.customerIndex!].sId!,
                      agrRef: Singleton.instance.agentRef ?? '',
                      agentName: Singleton.instance.agentName ?? '',
                      agentType:
                          (Singleton.instance.usertype == Constants.telecaller)
                              ? 'TELECALLER'
                              : 'COLLECTOR',
                    );
                    Map<String, dynamic> postResult =
                        await APIRepository.apiRequest(
                      APIRequestType.POST,
                      HttpUrl.callCustomerUrl,
                      requestBodydata: jsonEncode(requestBodyData),
                    );
                    if (postResult[Constants.success]) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext builderContext) {
                            _timer =
                                Timer(const Duration(seconds: 5), () async {
                              Navigator.of(context).pop();
                              _timer.cancel();
                              if (state.customerIndex! <
                                  bloc.resultList.length) {
                                List<Address> tempMobileList = [];
                                bloc.resultList[state.customerIndex!].address
                                    ?.asMap()
                                    .forEach((i, element) {
                                  if (element.cType == 'mobile') {
                                    tempMobileList.add(element);
                                  }
                                });
                                if (state.phoneIndex! < tempMobileList.length) {
                                  CaseDetailsBloc caseDetailsloc =
                                      CaseDetailsBloc(bloc)
                                        ..add(CaseDetailsInitialEvent(
                                          paramValues: {
                                            'caseID': bloc
                                                .resultList[
                                                    state.customerIndex!]
                                                .caseId,
                                            'isAutoCalling': true,
                                            'customerIndex':
                                                state.customerIndex,
                                            'phoneIndex': state.phoneIndex,
                                            'mobileList': tempMobileList,
                                            'context': context,
                                          },
                                          context: context,
                                        ));
                                  await phoneBottomSheet(
                                      context, caseDetailsloc, 0);
                                  // Navigator.pushNamed(
                                  //     context, AppRoutes.caseDetailsScreen,
                                  //     arguments: {
                                  //       'caseID': bloc
                                  //           .resultList[state.customerIndex!].caseId,
                                  //       'isAutoCalling': true,
                                  //       'customerIndex': state.customerIndex,
                                  //       'phoneIndex': state.phoneIndex,
                                  //       'mobileList': tempMobileList,
                                  //     });
                                } else {
                                  bloc.add(StartCallingEvent(
                                    customerIndex: state.customerIndex! + 1,
                                    phoneIndex: 0,
                                    // customerList: widget.bloc.allocationBloc
                                    //     .resultList[(widget.bloc
                                    //         .paramValue['customerIndex']) +
                                    //     1],
                                  ));
                                }
                                // else {
                                // }
                                // if(bloc.resultList[state.customerIndex].address. )
                              } else {
                                Singleton.instance.startCalling = false;
                              }
                            });

                            return const AlertDialog(
                              backgroundColor: Colors.white,
                              title: CustomLoadingWidget(),
                            );
                          }).then((val) {
                        if (_timer.isActive) {
                          _timer.cancel();
                        }
                      });
                    }
                  } else {
                    bloc.add(StartCallingEvent(
                      customerIndex: state.customerIndex! + 1,
                      phoneIndex: 0,
                    ));
                  }
                }

                // else {}
              } else {
                // AppUtils.makePhoneCall(
                //   'tel:' + '6374578994',
                // );
              }
            }
          } else {
            AppUtils.showToast('Auto Calling is Complete');
          }
        }
        if (state is UpdateNewValueState) {
          setState(() {});
        }

        if (state is NavigateCaseDetailState) {
          dynamic returnValue = await Navigator.pushNamed(
              context, AppRoutes.caseDetailsScreen,
              arguments: state.paramValues);
          RetrunValueModel retrunModelValue =
              RetrunValueModel.fromJson(Map<String, dynamic>.from(returnValue));

          if (retrunModelValue.isSubmit) {
            bloc.add(UpdateNewValuesEvent(retrunModelValue.caseId));
          }
        }
        if (state is NavigateSearchPageState) {
          final dynamic returnValue =
              await Navigator.pushNamed(context, AppRoutes.searchScreen);
          if (returnValue != null) {
            // print('search data--------->');
            // print(returnValue.accountNumber);
            bloc.add(SearchReturnDataEvent(returnValue: returnValue));
            var data = returnValue as SearchingDataModel;
            if (data.isStarCases!) {
              searchBasedOnValue = "Stared Cases (High Priority)";
            } else if (data.isMyRecentActivity!) {
              searchBasedOnValue = "My Recent Activity";
            } else if (data.accountNumber!.isNotEmpty) {
              searchBasedOnValue = "Account Number: " + data.accountNumber!;
            } else if (data.customerName!.isNotEmpty) {
              searchBasedOnValue = "Customer Name: " + data.customerName!;
            } else if (data.dpdBucket!.isNotEmpty) {
              searchBasedOnValue = "DPD/Bucket: " + data.dpdBucket!;
            } else if (data.status!.isNotEmpty) {
              searchBasedOnValue = "Status: " + data.status!;
            } else if (data.pincode!.isNotEmpty) {
              searchBasedOnValue = "Pincode: " + data.pincode!;
            } else if (data.customerID!.isNotEmpty) {
              searchBasedOnValue = "Customer ID: " + data.customerID!;
            }
          }
        }

        if (state is SearchReturnDataState) {
          isCaseDetailLoading = false;
        }

        if (state is AllocationLoadedState) {
          //List<Result>
          if (state.successResponse is List<Result>) {
            resultList = state.successResponse;
          }
        }

        if (state is TapPriorityState) {
          if (state.successResponse is List<Result>) {
            resultList = state.successResponse;
          }
          isCaseDetailLoading = false;
          bloc.isShowSearchPincode = false;
        }

        if (state is TapBuildRouteState) {
          if (state.successResponse is List<Result>) {
            resultList = state.successResponse;
          }
          isCaseDetailLoading = false;
          bloc.isShowSearchPincode = false;
        }

        if (state is FilterSelectOptionState) {
          bloc.selectedOption = 0;
          bloc.add(TapPriorityEvent());
        }

        if (state is PriorityLoadMoreState) {
          if (state.successResponse is List<Result>) {
            if (bloc.hasNextPage) {
              resultList.addAll(state.successResponse);
            }
          }
        }

        if (state is BuildRouteLoadMoreState) {
          if (state.successResponse is List<Result>) {
            if (bloc.hasNextPage) {
              resultList.addAll(state.successResponse);
            }
          }
        }

        if (state is UpdateStaredCaseState) {
          if (state.isStared) {
            setState(() {
              bloc.starCount++;
            });
            var postData =
                UpdateStaredCase(caseId: state.caseId, starredCase: true);
            await APIRepository.apiRequest(
              APIRequestType.POST,
              HttpUrl.updateStaredCase,
              requestBodydata: jsonEncode(postData),
            );
          } else {
            setState(() {
              bloc.starCount--;
            });
            var postData =
                UpdateStaredCase(caseId: state.caseId, starredCase: false);
            await APIRepository.apiRequest(
              APIRequestType.POST,
              HttpUrl.updateStaredCase,
              requestBodydata: jsonEncode(postData),
            );
          }
        }

        if (state is TapAreYouAtOfficeOptionsState) {
          Position positions = Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
          );
          if (Geolocator.checkPermission().toString() !=
              PermissionStatus.granted.toString()) {
            Position res = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best);
            setState(() {
              positions = res;
            });
          }
          var requestBodyData = AreYouAtOfficeModel(
            eventId: ConstantEventValues.areYouAtOfficeEventId,
            eventType: 'Office Check In',
            eventAttr: AreYouAtOfficeEventAttr(
              altitude: positions.altitude,
              accuracy: positions.accuracy,
              heading: positions.heading,
              speed: positions.speed,
              latitude: positions.latitude,
              longitude: positions.longitude,
            ),
            createdBy: Singleton.instance.agentRef ?? '',
            agentName: Singleton.instance.agentName ?? '',
            contractor: Singleton.instance.contractor ?? '',
            eventModule: 'Field Allocation',
            eventCode: ConstantEventValues.areYouAtOfficeEvenCode,
          );
          Map<String, dynamic> postResult = await APIRepository.apiRequest(
            APIRequestType.POST,
            HttpUrl.areYouAtOfficeUrl(),
            requestBodydata: jsonEncode(requestBodyData),
          );
          if (postResult[Constants.success]) {
            SharedPreferences _pref = await SharedPreferences.getInstance();
            setState(() {
              bloc.areyouatOffice = false;
              _pref.setBool('areyouatOffice', false);
            });
            AppUtils.showToast(Constants.successfullySubmitted);
          }
        }

        if (state is AutoCallContactHealthUpdateState) {
          print(
              "data of new health ==> ${Singleton.instance.updateHealthStatus}");
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                bloc.resultList[state.caseIndex!].address?[state.contactIndex!]
                    .health = '2';
                break;
              case 1:
                bloc.resultList[state.caseIndex!].address?[state.contactIndex!]
                    .health = '1';
                break;
              case 2:
                bloc.resultList[state.caseIndex!].address?[state.contactIndex!]
                    .health = '0';
                break;
              default:
                bloc.resultList[state.caseIndex!].address?[state.contactIndex!]
                    .health = data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<AllocationBloc, AllocationState>(
        bloc: bloc,
        builder: (BuildContext context, AllocationState state) {
          if (state is AllocationLoadingState) {
            return const CustomLoadingWidget();
          }
          return bloc.isNoInternetAndServerError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(bloc.isNoInternetAndServerErrorMsg!),
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            bloc.add(AllocationInitialEvent(context));
                          },
                          icon: const Icon(Icons.refresh)),
                    ],
                  ),
                )
              : Scaffold(
                  backgroundColor: ColorResource.colorF7F8FA,
                  floatingActionButton: Visibility(
                    visible: bloc.isShowSearchFloatingButton,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Visibility(
                              visible: bloc.isMessageThere,
                              child: SizedBox(
                                width: 175,
                                // padding: EdgeInsets.all(10),
                                child: CustomButton(
                                  Languages.of(context)!.message,
                                  alignment: MainAxisAlignment.end,
                                  cardShape: 50,
                                  isTrailing: true,
                                  leadingWidget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 40,
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        decoration: const BoxDecoration(
                                          color: ColorResource.colorFFFFFF,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                            child: CustomText(
                                          bloc.messageCount.toString(),
                                          color: ColorResource.colorEA6D48,
                                          fontSize: FontSize.twelve,
                                          fontWeight: FontWeight.w700,
                                          lineHeight: 1,
                                        )),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    bloc.add(MessageEvent());
                                    AppUtils.showToast('Message');
                                  },
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CustomFloatingActionButton(
                            onTap: () async {
                              bloc.add(NavigateSearchPageEvent());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: bloc.areyouatOffice,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: ColorResource.colorffffff,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: ColorResource.colorECECEC,
                                      width: 1.0),
                                ),
                                child: Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ImageResource.location),
                                    const SizedBox(
                                      width: 13.0,
                                    ),
                                    SizedBox(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.3,
                                      child: CustomText(
                                        Languages.of(context)!.areYouAtOffice,
                                        fontSize: FontSize.twelve,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color000000,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    SizedBox(
                                        width: 76,
                                        height: 40,
                                        child: CustomButton(
                                          Languages.of(context)!.yes,
                                          fontSize: FontSize.twelve,
                                          borderColor:
                                              ColorResource.colorEA6D48,
                                          buttonBackgroundColor:
                                              ColorResource.colorEA6D48,
                                          cardShape: 5,
                                          onTap: () {
                                            bloc.add(
                                                TapAreYouAtOfficeOptionsEvent());
                                          },
                                        )),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    SizedBox(
                                        width: 85,
                                        height: 40,
                                        child: CustomButton(
                                          Languages.of(context)!.no,
                                          fontSize: FontSize.twelve,
                                          textColor: ColorResource.color23375A,
                                          buttonBackgroundColor:
                                              ColorResource.colorffffff,
                                          cardShape: 5,
                                          onTap: () {
                                            bloc.add(
                                                TapAreYouAtOfficeOptionsEvent());
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Visibility(
                              visible: bloc.isShowSearchPincode,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(35, 55, 90, 0.27),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      Languages.of(context)!.searchbasedOn,
                                      fontSize: FontSize.ten,
                                      color: ColorResource.color000000,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // const SizedBox(height: 10.0,),
                                    CustomText(
                                      // Languages.of(context)!.pincode + ' 636808',
                                      searchBasedOnValue ?? "",
                                      fontSize: FontSize.fourteen,
                                      color: ColorResource.color000000,
                                      fontWeight: FontWeight.w700,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   height: 15.0,
                            // ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Wrap(
                                runSpacing: 0,
                                spacing: 10,
                                children: _buildFilterOptions(),
                              ),
                            ),
                            const SizedBox(
                              height: 13.0,
                            ),
                            bloc.showFilterDistance
                                ? _buildBuildRoute()
                                : const SizedBox(),
                            // const SizedBox(
                            //   height: 5.0,
                            // ),
                            // Expanded(child: WidgetUtils.buildListView(bloc)),
                          ],
                        ),
                      ),
                      bloc.isAutoCalling
                          ? Expanded(
                              child:
                                  AutoCalling.buildAutoCalling(context, bloc))
                          : Expanded(
                              child: isCaseDetailLoading
                                  ? const CustomLoadingWidget()
                                  : resultList.isEmpty
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 50, right: 20, left: 20),
                                              child: NoCaseAvailble
                                                  .buildNoCaseAvailable(),
                                            ),
                                          ],
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 0.0),
                                          child: CustomCardList.buildListView(
                                            bloc,
                                            resultData: resultList,
                                            listViewController: _controller,
                                          ),
                                        )),
                    ],
                  ),
                  bottomNavigationBar: Visibility(
                    visible: bloc.isAutoCalling,
                    child: Container(
                      height: 88,
                      decoration: const BoxDecoration(
                          color: ColorResource.colorffffff,
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.13)))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(13, 5, 20, 18),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: CustomButton(
                                Languages.of(context)!.stop.toUpperCase(),
                                fontSize: FontSize.sixteen,
                                textColor: ColorResource.colorEA6D48,
                                fontWeight: FontWeight.w600,
                                cardShape: 5,
                                buttonBackgroundColor:
                                    ColorResource.colorffffff,
                                borderColor: ColorResource.colorffffff,
                                onTap: () async {
                                  SharedPreferences _pref =
                                      await SharedPreferences.getInstance();
                                  _pref.setInt('autoCallingIndexValue', 0);
                                  _pref.setInt('autoCallingSubIndexValue', 0);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: CustomButton(
                                // Languages.of(context)!
                                //     .startCalling
                                //     .toUpperCase(),
                                null,

                                cardShape: 5,
                                trailingWidget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: SvgPicture.asset(ImageResource.vector),
                                ),
                                isLeading: true,
                                isTrailing: true,
                                leadingWidget: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: CustomText(
                                      Languages.of(context)!
                                          .startCalling
                                          .toUpperCase(),
                                      fontWeight: FontWeight.w600,
                                      color: ColorResource.colorFFFFFF,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  bloc.add(StartCallingEvent(
                                    customerIndex: 0,
                                    phoneIndex: 0,
                                    customerList: bloc.resultList.first,
                                  ));
                                },
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
