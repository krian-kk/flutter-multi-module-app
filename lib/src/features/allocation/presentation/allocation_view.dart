import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:design_system/colors.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';

// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/src/features/allocation/presentation/custom_card_list.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/phone_screen/phone_screen.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/allocation/bloc/allocation_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

class AllocationScreen extends StatefulWidget {
  const AllocationScreen({Key? key, this.myValueSetter}) : super(key: key);

  // final Function? returnFuntion;
  final ValueSetter<int>? myValueSetter;

  @override
  State<AllocationScreen> createState() => _AllocationScreenState();
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (kDebugMode) {
      AppUtils.showToast('Work manager triggered ');
      print('Native called background task: $task');
    } //simpleTask will be emitted here.
    if (await Permission.location.isGranted) {
      final Position result = await Geolocator.getCurrentPosition();
      await APIRepository.apiRequest(APIRequestType.put,
          '${HttpUrl.updateDeviceLocation}lat=${result.latitude}&lng=${result.longitude}');
    }
    return Future.value(true);
  });
}

class _AllocationScreenState extends State<AllocationScreen>
    with WidgetsBindingObserver {
  late AllocationBloc bloc;
  bool isSubmitRUOffice = false;
  String? currentAddress;
  bool isCaseDetailLoading = false;
  bool isOffline = false;
  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );
  List<PriorityCaseListModel> resultList = <PriorityCaseListModel>[];
  String? searchBasedOnValue;
  String version = '';
  late Timer _timer;
  String? internetAvailability;
  bool isToastShow = false;
  List<String> filterOptions = <String>[];

  // The controller for the ListView
  late ScrollController _controller;

  // CollectionReference<Map<String, dynamic>>? collectionReference;

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      internetChecking();
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('initState--> $this');
    firebase();
    bloc = BlocProvider.of<AllocationBloc>(context);
    // collectionReference = FirebaseFirestore.instance
    //     .collection(Singleton.instance.firebaseDatabaseName)
    //     .doc(Singleton.instance.agentRef)
    //     .collection(Constants.firebaseCase);
    _controller = ScrollController()..addListener(_loadMore);

    // For offline checking only
    internetChecking();
    if (Singleton.instance.usertype == Constants.fieldagent) {
      getCurrentLocation();
    }
  }

  Future firebase() async {
    // await FirebaseFirestore.instance
    //     .collection(Singleton.instance.firebaseDatabaseName)
    //     .doc(Singleton.instance.agentRef)
    //     .collection(Constants.firebaseCase)
    //     .get()
    //     .then((value) {
    //   for (var element in value.docs) {
    //     debugPrint('Element--> $element');
    //   }
    // });
    return;
  }

  Future<void> locationTracker() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    if (Platform.isAndroid) {
      if (kDebugMode) {
        AppUtils.showToast('Platform.isAndroid');
      }
      await Workmanager().registerPeriodicTask(
        'uniqueNameIdentifier',
        'uniqueNamePeriodicTask',
        constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: true,
            requiresCharging: true,
            requiresDeviceIdle: true,
            requiresStorageNotLow: true),
        initialDelay: const Duration(seconds: 5),
        frequency: const Duration(minutes: 15),
      );
    } else {
      if (kDebugMode) {
        AppUtils.showToast('Platform.isIOS ');
      }
      await Workmanager().registerPeriodicTask(
        'uniqueNameIdentifier',
        'uniqueNamePeriodicTask',
        frequency: const Duration(minutes: 15),
        initialDelay: const Duration(seconds: 5),
        constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: true,
            requiresCharging: true,
            requiresDeviceIdle: true,
            requiresStorageNotLow: true),
      );
    }
  }

  Future<void> internetChecking() async {
    if ((!Singleton.instance.isFirstTime) ||
        ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      await Connectivity().checkConnectivity().then((value) {
        setState(() {
          internetAvailability = value.name;
        });
        if (value.name == 'none') {
          resultList.clear();
          isOffline = true;
          bloc.hasNextPage = false;
          bloc.resultList = [];
          resultList = [];
        } else {
          isOffline = false;
          resultList.clear();
          bloc.hasNextPage = true;
          bloc.resultList = [];
          resultList = [];
          BlocProvider.of<AllocationBloc>(context)
              .add(AllocationInitialEvent());
        }
      });
    }
    Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        internetAvailability = event.name;
        if (event.name == 'none') {
          resultList.clear();
          isOffline = true;
          bloc.hasNextPage = false;
          bloc.resultList = [];
          resultList = [];
        } else {
          isOffline = false;
          resultList.clear();
          bloc.hasNextPage = true;
          bloc.resultList = [];
          resultList = [];
          BlocProvider.of<AllocationBloc>(context)
              .add(AllocationInitialEvent());
        }
      });
      Singleton.instance.isFirstTime = false;
    });
  }

  //get current location lat, alng and address
  getCurrentLocation() async {
    if (ConnectivityResult.none != await Connectivity().checkConnectivity()) {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        final Position result = await Geolocator.getCurrentPosition();
        if (mounted) {
          setState(() {
            position = result;
          });
        }
        final List<Placemark> placeMarks =
            await placemarkFromCoordinates(result.latitude, result.longitude);
        if (mounted) {
          setState(() {
            currentAddress =
                '${placeMarks.toList().first.street}, ${placeMarks.toList().first.subLocality}, ${placeMarks.toList().first.postalCode}';
          });
          await APIRepository.apiRequest(APIRequestType.put,
              '${HttpUrl.updateDeviceLocation}lat=${position.latitude}&lng=${position.longitude}');
          await locationTracker();
        }
      } else {
        await openAppSettings();
      }
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
        backgroundColor: ColorResourceDesign.colorFFFFFF,
        builder: (BuildContext context) {
          return MapNavigation(
            multipleLatLong: bloc.multipleLatLong,
          );
        });
  }

  messageShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResourceDesign.colorFFFFFF,
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

  // This function will be triggered whenever the user scroll
  // to near the bottom of the list view
  _loadMore() async {
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
                      color: ColorResourceDesign.color101010,
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
                        color: ColorResourceDesign.color23375A,
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
    final List<Widget> widgets = [];
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
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(85),
          color: distance == bloc.selectedDistance
              ? ColorResourceDesign.color23375A
              : Colors.white,
        ),
        child: Center(
          child: CustomText(
            distance,
            fontSize: FontSize.twelve,
            fontWeight: FontWeight.w700,
            color: distance == bloc.selectedDistance
                ? Colors.white
                : ColorResourceDesign.color000000,
          ),
        ),
      ),
    );
  }

  Future<void> phoneBottomSheet(
      BuildContext buildContext, CaseDetailsBloc casedetailbloc, int i) {
    return showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return PhoneScreen(
            bloc: casedetailbloc,
            index: i,
            customerLoanUserWidget: CustomLoanUserDetails(
              userName: casedetailbloc
                      .caseDetailsAPIValue.result?.caseDetails?.cust ??
                  '',
              userId:
                  '${casedetailbloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
              userAmount: casedetailbloc
                      .caseDetailsAPIValue.result?.caseDetails?.due
                      ?.toDouble() ??
                  0.0,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocBuilder<AllocationBloc, AllocationState>(
      builder: (context, state) {
        return BlocListener<AllocationBloc, AllocationState>(
          bloc: bloc,
          listener: (BuildContext context, AllocationState state) async {
            // Map<String, dynamic>? data = element.data();
            // // log('message $data');
            // resultList.add(Result.fromJson(data));
            // if (Result.fromJson(data).starredCase == true) {
            //   starCount++;
            // }
            // if (state is FirebaseStoredCompletionState) {
            //   // collectionReference = FirebaseFirestore.instance
            //   //     .collection(Singleton.instance.firebaseDatabaseName)
            //   //     .doc(Singleton.instance.agentRef)
            //   //     .collection(Constants.firebaseCase);
            //
            //   Future.delayed(const Duration(milliseconds: 60), () {
            //     widget.myValueSetter!(0);
            //   });
            //   Future.delayed(const Duration(seconds: 5), () {
            //     widget.myValueSetter!(0);
            //     AppUtils.showToast('App synced with local');
            //     debugPrint('App synced with local');
            //     setState(() {
            //       isToastShow = true;
            //     });
            //     bloc.add(AllocationInitialEvent(context, myValueSetter: (values) {
            //       widget.myValueSetter!(values);
            //     }));
            //   });
            // }

            /**Offline code*/
            // if (state is AllocationOfflineState) {
            //     if(state.showErrorMessage){
            //       bloc.isNoInternetAndServerErrorMsg = Languages.of(context)!.noInternetConnection;
            //     }
            //   if (state.successResponse ==
            //       Singleton.instance.offlineDataSynchronization) {
            //     // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore
            //     //     .instance
            //     //     .collection(Singleton.instance.firebaseDatabaseName)
            //     //     .doc(Singleton.instance.agentRef)
            //     //     .collection(Constants.firebaseCase)
            //     //     .get(const GetOptions(source: Source.server))
            //     //     .asStream();
            //   } else {
            //     isOffline = true;
            //     debugPrint('Offline state in bloc $isOffline');
            //   }
            // }
            if (state is NoInternetConnectionState) {
              isOffline = true;
              AppUtils.noInternetSnackbar(context);
            }
            if (state is CaseListViewLoadingState) {
              isCaseDetailLoading = true;
            }

            if (state is TapAreYouAtOfficeOptionsSuccessState) {
              AppUtils.showToast(Languages.of(context)!.successfullySubmitted);
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
                BlocProvider.of<AllocationBloc>(context).add(
                    StartCallingAdditionalHandlingEvent(
                        customerIndex: state.customerIndex,
                        phoneIndex: state.phoneIndex));
              } else {
                Singleton.instance.startCalling = false;
                AppUtils.showToast(
                  Languages.of(context)!.autoCallingIsComplete,
                );
              }
            }

            if (state is GetAgencyDetailsFailureState) {
              AppUtils.showToast(
                  Languages.of(context)!.doesntGetTheAgentAddress);
            }

            if (state is PostCallCustomerSuccessState) {
              await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext builderContext) {
                    _timer = Timer(const Duration(seconds: 5), () async {
                      Navigator.of(context).pop();
                      _timer.cancel();
                      if (state.customerIndex! <
                          bloc.autoCallingResultList.length) {
                        final List<Address> tempMobileList = [];
                        bloc.autoCallingResultList[state.customerIndex!].address
                            ?.asMap()
                            .forEach((i, element) {
                          if (element.cType == 'mobile') {
                            tempMobileList.add(element);
                          }
                        });
                        // if (state.phoneIndex! < tempMobileList.length)
                        // {
                        //   final CaseDetailsBloc caseDetailsloc =
                        //       CaseDetailsBloc(bloc)
                        //         ..add(CaseDetailsInitialEvent(
                        //           paramValues: {
                        //             'caseID': bloc
                        //                 .autoCallingResultList[state.customerIndex!]
                        //                 .caseId,
                        //             'isAutoCalling': true,
                        //             'caseIndex': state.customerIndex,
                        //             'customerIndex': state.customerIndex,
                        //             'phoneIndex': state.phoneIndex,
                        //             'contactIndex': state.phoneIndex,
                        //             'mobileList': tempMobileList,
                        //             'context': context,
                        //             'callId': state.callId,
                        //           },
                        //           context: context,
                        //         ));
                        //   await Future.delayed(const Duration(milliseconds: 1500));
                        //   await phoneBottomSheet(context, caseDetailsloc, 0);
                        // }
                        // else {
                        //   bloc.add(StartCallingEvent(
                        //     customerIndex: state.customerIndex! + 1,
                        //     phoneIndex: 0,
                        //   ));
                        // }
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

            if (state is PostCallCustomerFailureState) {
              AppUtils.showToast(Languages.of(context)!.pleaseCallAgain);
            }

            if (state is PhoneIndexLesserThanTempMobileListEvent) {
              bloc.add(StartCallingEvent(
                customerIndex: state.customerIndex! + 1,
                phoneIndex: 0,
              ));
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
            //todo
            // if (state is NavigateCaseDetailState) {
            //   try {
            //     final dynamic returnValue = await Navigator.pushNamed(
            //         context, AppRoutes.caseDetailsScreen,
            //         arguments: CaseDetailsNaviagationModel(state.paramValues,
            //             allocationBloc: bloc));
            //     // If user will be offline data stored into firebase ->
            //     // so there is no need to update while back
            //     if (state.paramValues['isOffline'] != null &&
            //         state.paramValues['isOffline'] == false) {
            //       final RetrunValueModel returnModelValue =
            //       RetrunValueModel.fromJson(
            //           Map<String, dynamic>.from(returnValue));
            //       if (returnModelValue.isSubmit) {
            //         bloc.add(TapPriorityEvent());
            //       }
            //     }
            //   } catch (e) {
            //     debugPrint(e.toString());
            //   }
            // }
            //TODO:SEARCH RETURN DATA STATE

            if (state is NavigateSearchPageState) {
              context.push(context.namedLocation('search'));
            }

            if (state is SearchReturnDataState) {
              isCaseDetailLoading = false;
            }

            if (state is AllocationLoadedState) {
              if (BlocProvider.of<AllocationBloc>(context).userType ==
                  Constants.fieldagent) {
                filterOptions = [
                  Languages.of(context)!.priority,
                  Languages.of(context)!.buildRoute,
                  Languages.of(context)!.mapView,
                ];

                BlocProvider.of<AllocationBloc>(context)
                    .add(GetCurrentLocationEvent());

                // if (BlocProvider.of<AllocationBloc>(context).isGoogleApiKeyNull ==
                //     true) {
                //   filterOptions = [
                //     Languages.of(context)!.priority,
                //   ];
                // } else {
                //   filterOptions = [
                //     Languages.of(context)!.priority,
                //     Languages.of(context)!.buildRoute,
                //     Languages.of(context)!.mapView,
                //   ];
                //   BlocProvider.of<AllocationBloc>(context)
                //       .add(GetCurrentLocationEvent());
                // }
              }

              if (BlocProvider.of<AllocationBloc>(context).userType ==
                  Constants.telecaller) {
                if (BlocProvider.of<AllocationBloc>(context).isCloudTelephony ==
                    false) {
                  filterOptions = [
                    Languages.of(context)!.priority,
                  ];
                } else {
                  filterOptions = [
                    Languages.of(context)!.priority,
                    Languages.of(context)!.autoCalling,
                  ];
                }
                BlocProvider.of<AllocationBloc>(context).areYouAtOffice = false;
              }

              //List<Result>
              if (state.successResponse is List<PriorityCaseListModel>) {
                resultList = state.successResponse;
                isOffline = false;
              } //List<Result>
              if (state.successResponse is String) {
                if (state.successResponse == 'offlineData') {
                  isOffline = true;
                  bloc.hasNextPage = false;
                }
                if (state.successResponse == 'synced') {
                  bloc.hasNextPage = true;
                }
              }
            }

            if (state is TapPriorityState) {
              if (state.successResponse is List<PriorityCaseListModel>) {
                resultList = state.successResponse;
              }
              isCaseDetailLoading = false;
              bloc.isShowSearchPincode = false;
            }

            if (state is TapBuildRouteState) {
              if (state.successResponse is List<PriorityCaseListModel>) {
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
              // debugPrint('Result length--> ${resultList.length}');
              if (state.successResponse is List<PriorityCaseListModel>) {
                if (BlocProvider.of<AllocationBloc>(context).hasNextPage) {
                  print("Here check alloc view ${resultList.runtimeType}");
                  resultList.addAll(
                      state.successResponse as List<PriorityCaseListModel>);
                }
              }
            }

            if (state is BuildRouteLoadMoreState) {
              if (state.successResponse is List<PriorityCaseListModel>) {
                if (BlocProvider.of<AllocationBloc>(context).hasNextPage) {
                  resultList.addAll(state.successResponse);
                }
              }
            }

            if (state is UpdateStarredCasesSuccessState) {
              if (ConnectivityResult.none !=
                  await Connectivity().checkConnectivity()) {
                setState(() {
                  bloc.resultList.insert(0, state.removedItem);
                  bloc.starCount++;
                });

                if (Singleton.instance.usertype == Constants.fieldagent) {
                  await FirebaseUtils.updateStarred(
                      isStarred: true, caseId: state.caseId);
                }
              } else {
                if (Singleton.instance.usertype == Constants.fieldagent) {
                  await FirebaseUtils.updateStarred(
                      isStarred: true, caseId: state.caseId);
                  setState(() {
                    bloc.starCount++;
                  });
                }
              }
            }

            if (state is UpdateUnStarredCasesSuccessState) {
              if (ConnectivityResult.none !=
                  await Connectivity().checkConnectivity()) {
                if (Singleton.instance.usertype == Constants.fieldagent &&
                    Singleton.instance.isOfflineEnabledContractorBased) {
                  await FirebaseUtils.updateStarred(
                      isStarred: false, caseId: state.caseId);
                  setState(() {
                    bloc.starCount--;
                  });
                }

                bloc.add(TapPriorityEvent());
              } else {
                if (Singleton.instance.usertype == Constants.fieldagent &&
                    Singleton.instance.isOfflineEnabledContractorBased) {
                  await FirebaseUtils.updateStarred(
                      isStarred: false, caseId: state.caseId);
                  setState(() {
                    bloc.starCount--;
                  });
                }
              }
            }

            if (state is AutoCallContactHealthUpdateState) {
              final UpdateHealthStatusModel data =
                  UpdateHealthStatusModel.fromJson(Map<String, dynamic>.from(
                      Singleton.instance.updateHealthStatus));
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
                    bloc
                        .autoCallingResultList[state.caseIndex!]
                        .address?[state.contactIndex!]
                        .health = data.currentHealth;
                    break;
                }
                bloc.add(AutoCallingContactSortEvent());
              });
            }
          },
          child: BlocBuilder<AllocationBloc, AllocationState>(
            bloc: bloc,
            builder: (BuildContext context, AllocationState state) {
              if (state is AllocationLoadingState ||
                  state is FirebaseStoredCompletionState) {
                return const SkeletonLoading();
              }
              if (state is LoadingState) {
                return const CustomLoadingWidget();
              } else {
                return Scaffold(
                  backgroundColor: ColorResourceDesign.colorF7F8FA,
                  floatingActionButton: internetAvailability != 'none'
                      ? Visibility(
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
                                                color: ColorResourceDesign
                                                    .colorFFFFFF,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: CustomText(
                                                bloc.messageCount.toString(),
                                                color: ColorResourceDesign
                                                    .colorEA6D48,
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
                        )
                      : const SizedBox(),
                  body: Column(
                    children: [
                      Visibility(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: bloc.areYouAtOffice,
                                child: Visibility(
                                  visible: internetAvailability != 'none'
                                      ? true
                                      : false,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: ColorResourceDesign.colorffffff,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              ColorResourceDesign.colorECECEC),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
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
                                                  color: ColorResourceDesign
                                                      .color000000,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: isSubmitRUOffice
                                              ? const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    child: CustomLoadingWidget(
                                                      radius: 14,
                                                      strokeWidth: 3,
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                        width: Languages.of(
                                                                        context)!
                                                                    .no
                                                                    .length ==
                                                                2
                                                            ? 75
                                                            : 64,
                                                        height: 40,
                                                        child: CustomButton(
                                                          Languages.of(context)!
                                                              .yes,
                                                          fontSize:
                                                              FontSize.twelve,
                                                          cardShape: 5,
                                                          borderColor:
                                                              ColorResourceDesign
                                                                  .color23375A,
                                                          buttonBackgroundColor:
                                                              ColorResourceDesign
                                                                  .color23375A,
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
                                                              Languages.of(
                                                                      context)!
                                                                  .no,
                                                              fontSize: FontSize
                                                                  .twelve,
                                                              borderColor:
                                                                  ColorResourceDesign
                                                                      .color23375A,
                                                              textColor:
                                                                  ColorResourceDesign
                                                                      .color23375A,
                                                              buttonBackgroundColor:
                                                                  ColorResourceDesign
                                                                      .colorffffff,
                                                              cardShape: 5,
                                                              onTap: () {
                                                                bloc.add(
                                                                    TapAreYouAtOfficeOptionsEvent());
                                                              },
                                                            ))
                                                        : Expanded(
                                                            child: SizedBox(
                                                                height: 40,
                                                                child:
                                                                    CustomButton(
                                                                  Languages.of(
                                                                          context)!
                                                                      .no,
                                                                  fontSize:
                                                                      FontSize
                                                                          .twelve,
                                                                  borderColor:
                                                                      ColorResourceDesign
                                                                          .color23375A,
                                                                  textColor:
                                                                      ColorResourceDesign
                                                                          .color23375A,
                                                                  buttonBackgroundColor:
                                                                      ColorResourceDesign
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
                                    color:
                                        const Color.fromRGBO(35, 55, 90, 0.27),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        Languages.of(context)!.searchbasedOn,
                                        fontSize: FontSize.ten,
                                        color: ColorResourceDesign.color000000,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomText(
                                        searchBasedOnValue ?? '',
                                        color: ColorResourceDesign.color000000,
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
                                  children: List.generate(filterOptions.length,
                                      (index) {
                                    return internetAvailability != 'none'
                                        ? ChoiceChip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
                                                side: BorderSide(width: 0.5)),
                                            labelPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 2),
                                            label: CustomText(
                                              filterOptions[index],
                                              fontSize: FontSize.twelve,
                                              lineHeight: 1,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  index == bloc.selectedOption
                                                      ? Colors.white
                                                      : ColorResourceDesign
                                                          .color000000,
                                            ),
                                            selected:
                                                bloc.selectedOption == index,
                                            selectedColor:
                                                ColorResourceDesign.color23375A,
                                            onSelected: (value) {
                                              if (index != 2) {
                                                setState(() {
                                                  bloc.selectedOption = value
                                                      ? index
                                                      : bloc.selectedOption;
                                                });
                                              }
                                              switch (index) {
                                                case 0:
                                                  setState(() {
                                                    bloc.showFilterDistance =
                                                        false;
                                                    bloc.add(
                                                        TapPriorityEvent());
                                                  });
                                                  break;
                                                case 1:
                                                  if (bloc.userType ==
                                                      Constants.fieldagent) {
                                                    setState(() {
                                                      bloc.add(TapBuildRouteEvent(
                                                          paramValues:
                                                              BuildRouteDataModel(
                                                                  lat: position
                                                                      .latitude
                                                                      .toString(),
                                                                  long: position
                                                                      .longitude
                                                                      .toString(),
                                                                  maxDistMeters:
                                                                      Constants
                                                                          .allDisMeters)));
                                                      bloc.showFilterDistance =
                                                          true;
                                                    });
                                                  } else {
                                                    bloc.add(
                                                        ShowAutoCallingEvent());
                                                  }
                                                  break;
                                                case 2:
                                                  bloc.add(
                                                    MapViewEvent(
                                                      paramValues:
                                                          BuildRouteDataModel(
                                                              lat: position
                                                                  .latitude
                                                                  .toString(),
                                                              long: position
                                                                  .longitude
                                                                  .toString(),
                                                              maxDistMeters:
                                                                  Constants
                                                                      .allDisMeters),
                                                    ),
                                                  );
                                                  break;
                                                default:
                                                  setState(() {
                                                    bloc.showFilterDistance =
                                                        false;
                                                  });
                                              }
                                            },
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                          )
                                        : const SizedBox();
                                  }),
                                ),
                              ),
                              const SizedBox(
                                height: 13.0,
                              ),
                              bloc.showFilterDistance
                                  ? _buildBuildRoute()
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      // bloc.isAutoCalling
                      //     ? Expanded(
                      //         child: AutoCalling.buildAutoCalling(context, bloc))
                      //     :
                      isOffline &&
                              Singleton.instance.isOfflineEnabledContractorBased
                          ? Container(
                              child: const Text('Commented autocalling'))
                          // StreamBuilder<QuerySnapshot>(
                          //             stream: FirebaseFirestore.instance
                          //                 .collection(
                          //                     Singleton.instance.firebaseDatabaseName)
                          //                 .doc(Singleton.instance.agentRef)
                          //                 .collection(Constants.firebaseCase)
                          //                 .limit(100)
                          //                 .snapshots(),
                          //             builder: (BuildContext context,
                          //                 AsyncSnapshot<QuerySnapshot> snapshot) {
                          //               if (snapshot.hasError) {
                          //                 return Column(
                          //                   children: [
                          //                     Padding(
                          //                       padding: const EdgeInsets.only(
                          //                           top: 50, right: 20, left: 20),
                          //                       child:
                          //                           NoCaseAvailble.buildNoCaseAvailable(
                          //                               messageContent:
                          //                                   'Something went wrong'),
                          //                     ),
                          //                   ],
                          //                 );
                          //               } else if (snapshot.connectionState ==
                          //                   ConnectionState.waiting) {
                          //                 const CustomLoadingWidget();
                          //               }
                          //               if (snapshot.connectionState ==
                          //                   ConnectionState.active) {
                          //                 // bloc.resultList.clear();
                          //                 // resultList.clear();
                          //
                          //                 bloc.resultList = [];
                          //                 resultList = [];
                          //                 bloc.starCount = 0;
                          //                 bloc.totalCases = 0;
                          //                 // setState(() {
                          //                 for (var element in snapshot.data!.docs) {
                          //                   final tempResult = Result.fromJson(element
                          //                       .data()! as Map<String, dynamic>);
                          //                   bloc.resultList.add(tempResult);
                          //                   resultList.add(tempResult);
                          //                   bloc.totalCases++;
                          //                   if (tempResult.starredCase == true) {
                          //                     bloc.starCount++;
                          //                   }
                          //                 }
                          //                 // resultList.sort((a, b) {
                          //                 //   return b.starredCase ? 1 : -1;
                          //                 //   // });
                          //                 // });
                          //                 // resultList.sort((a, b) {
                          //                 //   if (b.starredCase) {
                          //                 //     return 1;
                          //                 //   }
                          //                 //   return -1;
                          //                 // });
                          //
                          //                 final List<Result> staredCasesList = [];
                          //                 for (var element in resultList) {
                          //                   if (element.starredCase) {
                          //                     staredCasesList.add(element);
                          //                   }
                          //                 }
                          //                 resultList.removeWhere(
                          //                     (element) => element.starredCase);
                          //                 resultList.insertAll(0, staredCasesList);
                          //                 for (var element in resultList) {
                          //                   debugPrint(
                          //                       'Cases accNo--> ${element.accNo}');
                          //                 }
                          //               }
                          //               return resultList.isEmpty
                          //                   ? Column(
                          //                       children: [
                          //                         Padding(
                          //                           padding: const EdgeInsets.only(
                          //                               top: 50, right: 20, left: 20),
                          //                           child: NoCaseAvailble
                          //                               .buildNoCaseAvailable(),
                          //                         ),
                          //                       ],
                          //                     )
                          //                   : Flexible(
                          //                       child: Padding(
                          //                         padding: const EdgeInsets.symmetric(
                          //                             horizontal: 20.0),
                          //                         child: CustomCardList.buildListView(
                          //                           bloc,
                          //                           resultData: resultList,
                          //                           listViewController: _controller,
                          //                         ),
                          //                       ),
                          //                     );
                          //             },
                          //           )
                          : Expanded(
                              child: isCaseDetailLoading
                                  ? const SkeletonLoading()
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
                                              horizontal: 20.0),
                                          child: CustomCardList.buildListView(
                                            bloc,
                                            resultData: resultList,
                                            listViewController: _controller,
                                          ),
                                        ),
                            ),
                    ],
                  ),
                  bottomNavigationBar: Visibility(
                    visible: bloc.isAutoCalling &&
                        bloc.autoCallingResultList.isNotEmpty,
                    child: Container(
                      height: 88,
                      decoration: const BoxDecoration(
                          color: ColorResourceDesign.colorffffff,
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
                                      color: ColorResourceDesign.colorFFFFFF,
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
              }
            },
          ),
        );
      },
    );
  }
}
