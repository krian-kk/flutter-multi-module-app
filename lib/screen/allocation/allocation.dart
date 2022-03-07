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
import 'package:origa/models/case_details_navigation_model.dart';
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

  bool isSubmitRUOffice = false;

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
    if (mounted) {
      setState(() {
        position = result;
      });
    }

    List<Placemark> placemarks =
        await placemarkFromCoordinates(result.latitude, result.longitude);
    if (mounted) {
      setState(() {
        currentAddress = placemarks.toList().first.street.toString() +
            ', ' +
            placemarks.toList().first.subLocality.toString() +
            ', ' +
            placemarks.toList().first.postalCode.toString();
      });
    }
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
        ),
      ),
    );
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
        width: 96,
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

        if (state is UpdateNewValueState) {
          bloc.resultList.asMap().forEach((index, value) {
            if (value.caseId == state.paramValue) {
              setState(() {
                if (Singleton.instance.usertype == Constants.telecaller) {
                  value.telSubStatus = state.selectedEventValue;
                } else {
                  value.collSubStatus = state.selectedEventValue;
                }
                if (state.selectedEventValue != null &&
                    state.updateFollowUpdate != null) {
                  value.fieldfollowUpDate = state.updateFollowUpdate;
                  value.followUpDate = state.updateFollowUpdate;
                }
              });
            }
          });
        }

        if (state is AutoCallingContactSortState) {
          setState(() {});
        }
        if (state is MessageState) {
          messageShowBottomSheet();
        }
        if (state is StartCallingState) {
          Singleton.instance.startCalling = true;
          setState(() {});
          if (bloc.customerCount < bloc.totalCount) {
            Map<String, dynamic> getAgencyDetailsData =
                await APIRepository.apiRequest(
                    APIRequestType.get, HttpUrl.voiceAgencyDetailsUrl);
            if (getAgencyDetailsData[Constants.success]) {
              if (Singleton.instance.cloudTelephony!) {
                Map<String, dynamic> jsonData = getAgencyDetailsData['data'];

                AgencyDetailsModel voiceAgencyDetails =
                    AgencyDetailsModel.fromJson(jsonData);

                if (state.customerIndex! < bloc.autoCallingResultList.length) {
                  List<Address> tempMobileList = [];
                  bloc.autoCallingResultList[state.customerIndex!].address
                      ?.asMap()
                      .forEach((i, element) {
                    if (element.cType == 'mobile') {
                      tempMobileList.add(element);
                    }
                  });
                  if (state.phoneIndex! < tempMobileList.length) {
                    var requestBodyData = CallCustomerModel(
                      from: voiceAgencyDetails.result?.agentAgencyContact ?? '',
                      // For hot_code testing
                      // from: '9585313659',
                      to: tempMobileList[state.phoneIndex!].value ?? '',
                      // For hot_code testing
                      // to: '7904557342',
                      callerId: voiceAgencyDetails
                                  .result?.voiceAgencyData?.first.callerIds !=
                              []
                          ? voiceAgencyDetails.result?.voiceAgencyData?.first
                              .callerIds?.first as String
                          : '0',
                      aRef: Singleton.instance.agentRef ?? '',
                      customerName: bloc
                          .autoCallingResultList[state.customerIndex!].cust!,
                      service: voiceAgencyDetails
                              .result?.voiceAgencyData?.first.agencyId ??
                          '0',
                      callerServiceID: voiceAgencyDetails
                              .result?.voiceAgencyData?.first.agencyId ??
                          '0',
                      caseId: bloc
                          .autoCallingResultList[state.customerIndex!].caseId!,
                      sId:
                          bloc.autoCallingResultList[state.customerIndex!].sId!,
                      agrRef: bloc.autoCallingResultList[state.customerIndex!]
                              .agrRef ??
                          '',
                      agentName: Singleton.instance.agentName ?? '',
                      agentType:
                          (Singleton.instance.usertype == Constants.telecaller)
                              ? 'TELECALLER'
                              : 'COLLECTOR',
                    );
                    Map<String, dynamic> postResult =
                        await APIRepository.apiRequest(
                      APIRequestType.post,
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
                                  bloc.autoCallingResultList.length) {
                                List<Address> tempMobileList = [];
                                bloc.autoCallingResultList[state.customerIndex!]
                                    .address
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
                                                .autoCallingResultList[
                                                    state.customerIndex!]
                                                .caseId,
                                            'isAutoCalling': true,
                                            'caseIndex': state.customerIndex,
                                            'customerIndex':
                                                state.customerIndex,
                                            'phoneIndex': state.phoneIndex,
                                            'contactIndex': state.phoneIndex,
                                            'mobileList': tempMobileList,
                                            'context': context,
                                            'callId': postResult['data']
                                                ['result'],
                                          },
                                          context: context,
                                        ));
                                  await phoneBottomSheet(
                                      context, caseDetailsloc, 0);
                                } else {
                                  bloc.add(StartCallingEvent(
                                    customerIndex: state.customerIndex! + 1,
                                    phoneIndex: 0,
                                  ));
                                }
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
                    } else {
                      AppUtils.showToast(
                          Languages.of(context)!.pleaseCallAgain);
                    }
                  } else {
                    bloc.add(StartCallingEvent(
                      customerIndex: state.customerIndex! + 1,
                      phoneIndex: 0,
                    ));
                  }
                }
              } else {
                // AppUtils.makePhoneCall(
                //   'tel:' + '6374578994',
                // );
              }
            } else {
              AppUtils.showToast(
                  Languages.of(context)!.doesntGetTheAgentAddress);
            }
          } else {
            Singleton.instance.startCalling = false;
            AppUtils.showToast(
              Languages.of(context)!.autoCallingIsComplete,
            );
          }
        }

        if (state is NavigateCaseDetailState) {
          try {
            dynamic returnValue = await Navigator.pushNamed(
                context, AppRoutes.caseDetailsScreen,
                arguments: CaseDetailsNaviagationModel(state.paramValues,
                    allocationBloc: bloc));
            RetrunValueModel returnModelValue = RetrunValueModel.fromJson(
                Map<String, dynamic>.from(returnValue));
            print(
                "return value case detail followUpDate ==> ${returnModelValue.followUpDate}");
            print(
                "return value case detail selectedClipValue ==> ${returnModelValue.selectedClipValue}");
            if (returnModelValue.isSubmit) {
              bloc.add(UpdateNewValuesEvent(
                returnModelValue.caseId,
                returnModelValue.selectedClipValue,
                returnModelValue.followUpDate,
              ));
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        if (state is NavigateSearchPageState) {
          final dynamic returnValue =
              await Navigator.pushNamed(context, AppRoutes.searchScreen);
          if (returnValue != null) {
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
              APIRequestType.post,
              HttpUrl.updateStaredCase,
              requestBodydata: jsonEncode(postData),
            );

            var removedItem = bloc.resultList[state.selectedIndex];
            bloc.resultList.removeAt(state.selectedIndex);
            setState(() {
              bloc.resultList.insert(0, removedItem);
            });
          } else {
            setState(() {
              bloc.starCount--;
            });
            var postData =
                UpdateStaredCase(caseId: state.caseId, starredCase: false);
            await APIRepository.apiRequest(
              APIRequestType.post,
              HttpUrl.updateStaredCase,
              requestBodydata: jsonEncode(postData),
            );

            var removedItem = bloc.resultList[state.selectedIndex];
            bloc.resultList.removeAt(state.selectedIndex);
            // To pick and add next starred false case
            var firstWhereIndex =
                bloc.resultList.indexWhere((note) => !note.starredCase);
            debugPrint('firstWhereIndex $firstWhereIndex');
            setState(() {
              bloc.resultList.insert(firstWhereIndex, removedItem);
            });
          }
        }

        if (state is TapAreYouAtOfficeOptionsState) {
          setState(() {
            isSubmitRUOffice = true;
          });
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
            APIRequestType.post,
            HttpUrl.areYouAtOfficeUrl(),
            requestBodydata: jsonEncode(requestBodyData),
          );
          if (postResult[Constants.success]) {
            SharedPreferences _pref = await SharedPreferences.getInstance();
            setState(() {
              bloc.areyouatOffice = false;
              isSubmitRUOffice = false;
              _pref.setBool('areyouatOffice', false);
            });
            AppUtils.showToast(Languages.of(context)!.successfullySubmitted);
          } else {
            setState(() {
              isSubmitRUOffice = false;
              bloc.areyouatOffice = true;
            });
          }
        }

        if (state is AutoCallContactHealthUpdateState) {
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));
          setState(() {
            switch (data.tabIndex) {
              case 0:
                bloc.autoCallingResultList[state.caseIndex!]
                    .address?[state.contactIndex!].health = '2';
                break;
              case 1:
                bloc.autoCallingResultList[state.caseIndex!]
                    .address?[state.contactIndex!].health = '1';
                break;
              case 2:
                bloc.autoCallingResultList[state.caseIndex!]
                    .address?[state.contactIndex!].health = '0';
                break;
              default:
                bloc.autoCallingResultList[state.caseIndex!]
                    .address?[state.contactIndex!].health = data.currentHealth;
                break;
            }
            bloc.add(AutoCallingContactSortEvent());
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
                                    AppUtils.showToast(
                                        Languages.of(context)!.message);
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              ImageResource.location),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: CustomText(
                                              Languages.of(context)!
                                                  .areYouAtOffice,
                                              fontSize: FontSize.twelve,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color000000,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: isSubmitRUOffice
                                          ? const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: CustomLoadingWidget(
                                                  radius: 14,
                                                  strokeWidth: 3,
                                                ),
                                              ),
                                            )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    width:
                                                        Languages.of(context)!
                                                                    .no
                                                                    .length ==
                                                                2
                                                            ? 75
                                                            : 64,
                                                    height: 40,
                                                    child: CustomButton(
                                                      Languages.of(context)!
                                                          .yes,
                                                      fontSize: FontSize.twelve,
                                                      borderColor: ColorResource
                                                          .colorEA6D48,
                                                      buttonBackgroundColor:
                                                          ColorResource
                                                              .colorEA6D48,
                                                      cardShape: 5,
                                                      isRemoveExtraPadding:
                                                          true,
                                                      onTap: () {
                                                        bloc.add(
                                                            TapAreYouAtOfficeOptionsEvent());
                                                      },
                                                    )),
                                                Languages.of(context)!
                                                            .no
                                                            .length ==
                                                        2
                                                    ? SizedBox(
                                                        width: 74,
                                                        height: 40,
                                                        child: CustomButton(
                                                          Languages.of(context)!
                                                              .no,
                                                          fontSize:
                                                              FontSize.twelve,
                                                          borderColor:
                                                              ColorResource
                                                                  .color23375A,
                                                          textColor:
                                                              ColorResource
                                                                  .color23375A,
                                                          buttonBackgroundColor:
                                                              ColorResource
                                                                  .colorffffff,
                                                          cardShape: 5,
                                                          onTap: () {
                                                            bloc.add(
                                                                TapAreYouAtOfficeOptionsEvent());
                                                          },
                                                        ))
                                                    : Expanded(
                                                        child: SizedBox(
                                                            // width: 85,
                                                            height: 40,
                                                            child: CustomButton(
                                                              Languages.of(
                                                                      context)!
                                                                  .no,
                                                              fontSize: FontSize
                                                                  .twelve,
                                                              borderColor:
                                                                  ColorResource
                                                                      .color23375A,
                                                              textColor:
                                                                  ColorResource
                                                                      .color23375A,
                                                              buttonBackgroundColor:
                                                                  ColorResource
                                                                      .colorffffff,
                                                              cardShape: 5,
                                                              onTap: () {
                                                                bloc.add(
                                                                    TapAreYouAtOfficeOptionsEvent());
                                                              },
                                                            )),
                                                      ),
                                              ],
                                            ),
                                    )
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
                                    CustomText(
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
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Wrap(
                                spacing: 10,
                                children: List.generate(
                                    bloc.selectOptions.length, (index) {
                                  return ChoiceChip(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        side: BorderSide(
                                            color: ColorResource.color23375A,
                                            width: 0.5)),
                                    labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    label: CustomText(
                                      bloc.selectOptions[index],
                                      fontSize: FontSize.twelve,
                                      lineHeight: 1,
                                      fontWeight: FontWeight.w700,
                                      color: index == bloc.selectedOption
                                          ? Colors.white
                                          : ColorResource.color000000,
                                    ),
                                    selected: bloc.selectedOption == index,
                                    selectedColor: ColorResource.color23375A,
                                    onSelected: (value) {
                                      setState(() {
                                        bloc.selectedOption =
                                            value ? index : bloc.selectedOption;
                                      });
                                      switch (index) {
                                        case 0:
                                          setState(() {
                                            bloc.showFilterDistance = false;
                                            bloc.add(TapPriorityEvent());
                                          });
                                          break;
                                        case 1:
                                          if (bloc.userType ==
                                              Constants.fieldagent) {
                                            setState(() {
                                              bloc.add(TapBuildRouteEvent(
                                                  paramValues:
                                                      BuildRouteDataModel(
                                                          lat: position.latitude
                                                              .toString(),
                                                          long: position
                                                              .longitude
                                                              .toString(),
                                                          maxDistMeters: Constants
                                                              .allDisMeters)));
                                              bloc.showFilterDistance = true;
                                            });
                                          } else {
                                            bloc.add(ShowAutoCallingEvent());
                                          }
                                          break;
                                        case 2:
                                          bloc.add(MapViewEvent(
                                              paramValues: BuildRouteDataModel(
                                                  lat: position.latitude
                                                      .toString(),
                                                  long: position.longitude
                                                      .toString(),
                                                  maxDistMeters:
                                                      Constants.allDisMeters)));
                                          setState(() {
                                            bloc.showFilterDistance = false;
                                          });
                                          break;
                                        default:
                                          setState(() {
                                            bloc.showFilterDistance = false;
                                          });
                                      }
                                    },
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                  );
                                }),
                              ),
                            ),

                            // Align(
                            //   alignment: Alignment.bottomLeft,
                            //   child: Wrap(
                            //     runSpacing: 0,
                            //     spacing: 10,
                            //     children: _buildFilterOptions(),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 13.0,
                            ),
                            bloc.showFilterDistance
                                ? _buildBuildRoute()
                                : const SizedBox(),
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
                    visible: bloc.isAutoCalling &&
                        bloc.autoCallingResultList.isNotEmpty,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: CustomButton(
                                null,
                                cardShape: 5,
                                trailingWidget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
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
                                      textAlign: TextAlign.center,
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
                                    // isStartFromButtonClick: true,
                                  ));
                                },
                              ),
                            ),
                            // ),
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
