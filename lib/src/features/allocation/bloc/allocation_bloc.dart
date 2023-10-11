import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:design_system/constant_event_values.dart';
import 'package:design_system/constants.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:domain_models/request_body/allocation/agency_details_model.dart';
import 'package:domain_models/request_body/allocation/are_you_at_office_model.dart';
import 'package:domain_models/request_body/allocation/call_customer_model.dart';
import 'package:domain_models/request_body/allocation/update_staredcase_model.dart';
import 'package:domain_models/response_models/allocation/communication_channel_model.dart';
import 'package:domain_models/response_models/allocation/contractor_all_information_model.dart';
import 'package:domain_models/response_models/allocation/contractor_details_model.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:domain_models/response_models/mapView/map_model.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preference_helper/preference_helper.dart';
import 'package:repository/allocation_repository.dart';
import 'package:repository/case_repository.dart';

part 'allocation_event.dart';

part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc({required this.repository, required this.caseRepository})
      : super(AllocationInitial()) {
    on<AllocationEvent>(_onEvent);
  }

  AllocationRepository repository;
  CaseRepositoryImpl caseRepository;

  late List<String> filterBuildRoute;

  int pageKey = 0;
  int tab = 0;
  int buildRouteSubTab = 0;
  bool areYouAtOffice = true;
  String? selectedDistance;

  bool isShowSearchPincode = false;

  bool isSubmitRUOffice = false;
  bool isGoogleApiKeyNull = false;
  bool isCloudTelephony = false;
  bool hasNextPage = false;
  int page = 1;

  int totalCases = 0;
  int starCount = 0;

  // Check which event to call for load more cases
  bool isPriorityLoadMore = false;
  bool showFilterDistance = false;

  List<PriorityCaseListModel> resultList = <PriorityCaseListModel>[];
  List<dynamic> autoCallingResultList = <dynamic>[];

  ContractorResult? contractorDetails;

  CommunicationChannelModel? communicationChannel;

  ContractorDetailsModel? customContractorDetails;

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
  String? currentAddress;
  static const _pageSize = 10;
  List<dynamic> multipleLatLong = <dynamic>[];
  String? userType;

  bool isOfflineTriggered = false;
  int selectedOption = 0;

  int customerCount = 0;
  int totalCount = 0;
  int tempTotalCount = 0;

  // int autoCallingTotalCaseCount = 0;

  String? agentName;
  String? agrRef;

  int indexValue = 0;

  // it's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? isNoInternetAndServerErrorMsg = '';

  int? messageCount = 0;
  bool isMessageThere = false;

  // There is used for pagination to scroll up

  // Show Telecaller Autocalling
  bool isAutoCalling = false;

  // Enable or Disable the search floating button
  bool isShowSearchFloatingButton = true;

  // Check which event to call for load more cases

  late Position currentLocation;

  ContractorDetailsModel contractorDetailsValue = ContractorDetailsModel();
  int? selectedStar;

  Future<void> _onEvent(
      AllocationEvent event, Emitter<AllocationState> emit) async {
    if (event is AllocationInitialEvent) {
      // if (event.myValueSetter != null) {
      //   event.myValueSetter!(0);
      // }

      emit(AllocationLoadingState());

      List<String?> initialData = await repository.allocationInitialData();
      userType = initialData[0]!;

      await PreferenceHelper.getString(keyPair: 'ruAtOfficeDay')
          .then((value) async {
        if (value != DateTime.now().day.toString()) {
          await PreferenceHelper.getBool(keyPair: 'areyouatOffice')
              .then((value) {
            areYouAtOffice = value;
          });
        } else {
          areYouAtOffice = false;
        }
      });

      isShowSearchPincode = false;
      selectedDistance = 'All';

      filterBuildRoute = <String>[
        StringResource.all,
        StringResource.under5km,
        StringResource.more5km,
      ];

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        emit(AllocationOfflineState(
            successResponse: 'offlineData', showErrorMessage: true));
      } else {
        isNoInternetAndServerError = false;
        //Now set priority case is a load more event
        isPriorityLoadMore = true;

        // bool appDataLoadedFromFirebase = false;
        // await PreferenceHelper.getBool(
        //         keyPair: Constants.appDataLoadedFromFirebase)
        //     .then((value) {
        //   appDataLoadedFromFirebase = value;
        // });

        final ApiResult<ContractorResult> data =
            await repository.getContractorDetails();

        await data.when(
            success: (ContractorResult? data) async {
              contractorDetails = data!;
              totalCases = 0;
              starCount = 0;

              final ApiResult<ContractorDetailsModel> customContractorData =
                  await repository.getCustomContractorDetailsData();
              await customContractorData.when(
                  success: (ContractorDetailsModel?
                      customContractorDataProcessed) async {
                    customContractorDetails = customContractorDataProcessed!;
                    Singleton.instance.feedbackTemplate =
                        customContractorDataProcessed;
                  },
                  failure: (NetworkExceptions? error) async {});

              // check and store cloudTelephony true or false
              final ApiResult<CommunicationChannelModel> comChannelData =
                  await repository.getCommunicationChannels();
              await comChannelData.when(
                  success: (CommunicationChannelModel?
                      comChannelDataProcessed) async {
                    communicationChannel = comChannelDataProcessed!;
                  },
                  failure: (NetworkExceptions? error) async {});

              Singleton.instance.cloudTelephony =
                  contractorDetails?.cloudTelephony ?? false;
              Singleton.instance.contractorInformations = contractorDetails;
              Singleton.instance.allocationTemplateConfig =
                  contractorDetails!.allocationTemplateConfig;

              String? googleMapsApiKey =
                  Singleton.instance.contractorInformations?.googleMapsApiKey;
              if (userType == Constants.fieldagent) {
                if (googleMapsApiKey == null || googleMapsApiKey.isEmpty) {
                  isGoogleApiKeyNull = true;
                } else {
                  await _setGoogleMapApiKey(googleMapsApiKey);
                }
              }
              // if cloudTelephone false means don't show autoCalling tab
              if (contractorDetails!.cloudTelephony == false &&
                  communicationChannel!.voiceApiKeyAvailable == false) {
                if (userType == Constants.telecaller) {
                  isCloudTelephony = false;
                }
              }
              if (contractorDetails!.cloudTelephony == true &&
                  communicationChannel!.voiceApiKeyAvailable == false) {
                if (userType == Constants.telecaller) {
                  isCloudTelephony = false;
                }
              }
            },
            failure: (NetworkExceptions? error) async {});

        final newItems = await caseRepository.getCasesFromServer(_pageSize, 1);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              if (result?.isNotEmpty == true && result != null) {
                resultList.clear();
                starCount = 0;

                result.forEach((element) {
                  resultList.add(element);
                  if (element.starredCase == true) {
                    starCount++;
                  }
                });

                if (resultList.length >= 10) {
                  hasNextPage = true;
                } else {
                  hasNextPage = false;
                }
              }
            },
            failure: (NetworkExceptions? error) async {});
        emit(AllocationLoadedState(successResponse: resultList));
      }
    }

    if (event is GetCurrentLocationEvent) {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        final Position result = await Geolocator.getCurrentPosition();

        position = result;

        final List<Placemark> placeMarks =
            await placemarkFromCoordinates(result.latitude, result.longitude);

        currentAddress =
            '${placeMarks.toList().first.street}, ${placeMarks.toList().first.subLocality}, ${placeMarks.toList().first.postalCode}';

        await repository.putCurrentLocation(
            position.latitude, position.longitude);
        emit(UpdatedCurrentLocationState());
      } else {
        await openAppSettings();
      }
    }

    if (event is TapPriorityEvent) {
      emit(CaseListViewLoadingState());
      page = 1;
      isPriorityLoadMore = true;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final newItems = await caseRepository.getCasesFromServer(_pageSize, 1);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              if (result?.isNotEmpty == true && result != null) {
                resultList.clear();
                starCount = 0;

                result.forEach((element) {
                  resultList.add(element);
                  if (element.starredCase == true) {
                    starCount++;
                  }
                });

                if (resultList.length >= 10) {
                  hasNextPage = true;
                } else {
                  hasNextPage = false;
                }
              }
            },
            failure: (NetworkExceptions? error) async {});
      }

      emit(TapPriorityState(successResponse: resultList));
    }

    if (event is PriorityLoadMoreEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final newItems =
            await caseRepository.getCasesFromServer(_pageSize, page);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              if (result?.isNotEmpty == true && result != null) {
                result.forEach((element) {
                  resultList.add(element);
                  if (element.starredCase == true) {
                    starCount++;
                  }
                });

                if (result.length >= 10) {
                  hasNextPage = true;
                } else {
                  hasNextPage = false;
                }
              }
            },
            failure: (NetworkExceptions? error) async {});
      }
      emit(PriorityLoadMoreState(successResponse: resultList));
    }

    //Build Route

    if (event is TapBuildRouteEvent) {
      emit(CaseListViewLoadingState());
      page = 1;
      isPriorityLoadMore = false;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final newItems = await caseRepository.getBuildRouteCases(
            _pageSize, 1, event.paramValues);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              if (result?.isNotEmpty == true && result != null) {
                resultList.clear();

                multipleLatLong.clear();
                result.forEach((element) {
                  resultList.add(element);
                  multipleLatLong.add(
                    MapMarkerModel(
                      caseId: element.caseId,
                      address: element.address?.first.value,
                      due: element.due.toString(),
                      name: element.cust,
                      latitude: element.location?.lat,
                      longitude: element.location?.lng,
                    ),
                  );
                });
                if (resultList.length >= 10) {
                  hasNextPage = true;
                } else {
                  hasNextPage = false;
                }
              }
            },
            failure: (NetworkExceptions? error) async {});
      }

      emit(TapBuildRouteState(successResponse: resultList));
    }

    if (event is BuildRouteLoadMoreEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final newItems = await caseRepository.getBuildRouteCases(
            _pageSize, page, event.paramValues);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              if (result?.isNotEmpty == true && result != null) {
                result.forEach((element) {
                  resultList.add(element);
                  multipleLatLong.add(
                    MapMarkerModel(
                      caseId: element.caseId,
                      address: element.address?.first.value,
                      due: element.due.toString(),
                      name: element.cust,
                      latitude: element.location?.lat,
                      longitude: element.location?.lng,
                    ),
                  );
                });
                if (resultList.length >= 10) {
                  hasNextPage = true;
                } else {
                  hasNextPage = false;
                }
              }
            },
            failure: (NetworkExceptions? error) async {});
      }
      emit(BuildRouteLoadMoreState(successResponse: resultList));
    }

    if (event is NavigateSearchPageEvent) {
      emit(NavigateSearchPageState());
    }

    if (event is TapAreYouAtOfficeOptionsEvent) {
      isSubmitRUOffice = true;
      emit(AreYouAtOfficeLoadingState());

      Position positions = Position(
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
      if (Geolocator.checkPermission().toString() !=
          PermissionStatus.granted.toString()) {
        final Position res = await Geolocator.getCurrentPosition();
        positions = res;
      }
      final requestBodyData = AreYouAtOfficeModel(
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

      final ApiResult<BaseResponse> data =
          await repository.areYouAtOffice(requestBodyData);
      await data.when(success: (BaseResponse? data) async {
        isSubmitRUOffice = false;
        areYouAtOffice = false;
        PreferenceHelper.setPreference('areyouatOffice', false);
        PreferenceHelper.setPreference(
            'ruAtOfficeDay', DateTime.now().day.toString());
        emit(TapAreYouAtOfficeOptionsSuccessState());
      }, failure: (NetworkExceptions? error) async {
        isSubmitRUOffice = false;
        areYouAtOffice = true;
        emit(TapAreYouAtOfficeOptionsFailureState());
      });
    }

    if (event is NavigateCaseDetailEvent) {
      emit(NavigateCaseDetailState(paramValues: event.paramValues));
    }

    if (event is UpdateStaredCaseEvent) {
      // Singleton.instance.buildContext = event.context;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        if (Singleton.instance.usertype == Constants.fieldagent) {
          resultList[event.selectedStarIndex].starredCase =
              !resultList[event.selectedStarIndex].starredCase;
        } else {
          emit(NoInternetConnectionState());
        }
      } else {
        resultList[event.selectedStarIndex].starredCase =
            !resultList[event.selectedStarIndex].starredCase;
      }

      final isStarred = resultList[event.selectedStarIndex].starredCase;
      if (ConnectivityResult.none != await Connectivity().checkConnectivity()) {
        final UpdateStaredCase postData =
            UpdateStaredCase(caseId: event.caseID, starredCase: isStarred);
        final data = await repository.updateStarredCases(postData);
        if (isStarred) {
          await data.when(
              success: (BaseResponse? result) async {
                final removedItem = resultList[event.selectedStarIndex];
                resultList.removeAt(event.selectedStarIndex);
                emit(UpdateStarredCasesSuccessState(
                    caseId: event.caseID, removedItem: removedItem));
              },
              failure: (NetworkExceptions? error) async {});
        } else {
          await data.when(
              success: (BaseResponse? result) async {
                emit(UpdateUnStarredCasesSuccessState(caseId: event.caseID));
              },
              failure: (NetworkExceptions? error) async {});
        }
      }
    }

    if (event is MapViewEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        emit(MapViewLoadingState());

        final newItems = await caseRepository.getBuildRouteCases(
            _pageSize, 1, event.paramValues);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              multipleLatLong.clear();
              if (result != null) {
                result.forEach((element) {
                  multipleLatLong.add(
                    MapMarkerModel(
                      caseId: element.caseId,
                      address: element.address?.first.value,
                      due: element.due.toString(),
                      name: element.cust,
                      latitude: element.location?.lat,
                      longitude: element.location?.lng,
                    ),
                  );
                });
              }
            },
            failure: (NetworkExceptions? error) async {});
      }

      emit(MapViewState());
    }

    if (event is ConnectedStopAndSubmitEvent) {
      final PriorityCaseListModel val =
          autoCallingResultList[event.customerIndex];
      autoCallingResultList.remove(val);
      customerCount++;
    }
    if (event is StartCallingEvent) {
      if (event.isIncreaseCount && event.customerIndex! <= totalCount) {
        final PriorityCaseListModel val =
            autoCallingResultList[event.customerIndex! - 1];
        autoCallingResultList.remove(val);
        // autoCallingResultList.add(val);
        customerCount++;
        emit(UpdateNewValueState());
      }
      Singleton.instance.startCalling = true;

      emit(StartCallingState(
        customerIndex: event.isIncreaseCount
            ? event.customerIndex! - 1
            : event.customerIndex!,
        phoneIndex: event.phoneIndex,
      ));
    }

    if (event is CallSuccessfullyConnectedEvent) {
      int? index = 0;
      await repository.getAutoCallingIndexValueAndUpdate().then((value) {
        index = value;
      });
      indexValue = index!;
      if (Singleton.instance.startCalling ?? false) {
        emit(StartCallingState());
      }
    }

    if (event is CallUnSuccessfullyConnectedEvent) {
      int? index, subIndex;
      await repository.getAutoCallingIndexValueAndUpdate().then((value) {
        index = value;
      });
      await repository.getAutoCallingSubIndexValueAndUpdate().then((value) {
        subIndex = value;
      });
      if (Singleton.instance.startCalling ?? false) {
        emit(StartCallingState());
      }
    }

    if (event is StartCallingAdditionalHandlingEvent) {
      final data = await repository.getAgencyDetailsData();
      await data.when(success: (AgencyResult? result) async {
        if (result != null) {
          if (Singleton.instance.cloudTelephony!) {
            if (event.customerIndex! < autoCallingResultList.length) {
              final List<Address> tempMobileList = [];
              autoCallingResultList[event.customerIndex!]
                  .address
                  ?.asMap()
                  .forEach((i, element) {
                if (element.cType == 'mobile') {
                  tempMobileList.add(element);
                }
              });
              if (event.phoneIndex! < tempMobileList.length) {
                final requestBodyData = CallCustomerModel(
                  from: result?.agentAgencyContact ?? '',
                  // for testing purpose using your number here
                  // from: 'test number',
                  to: tempMobileList[event.phoneIndex!].value ?? '',
                  callerId: result?.voiceAgencyData?.first.callerIds != []
                      ? result?.voiceAgencyData?.first.callerIds?.first
                          as String
                      : '0',
                  aRef: Singleton.instance.agentRef ?? '',
                  customerName:
                      autoCallingResultList[event.customerIndex!].cust!,
                  service: result?.voiceAgencyData?.first.agencyId ?? '0',
                  callerServiceID: result?.voiceAgencyData?.first.agencyId,
                  contractor: Singleton.instance.contractor,
                  caseId: autoCallingResultList[event.customerIndex!].caseId!,
                  sId: autoCallingResultList[event.customerIndex!].sId!,
                  agrRef:
                      autoCallingResultList[event.customerIndex!].agrRef ?? '',
                  agentName: Singleton.instance.agentName ?? '',
                  agentType:
                      (Singleton.instance.usertype == Constants.telecaller)
                          ? 'TELECALLER'
                          : 'COLLECTOR',
                );
                final postData =
                    await repository.postCallCustomer(requestBodyData);
                await postData.when(success: (BaseResponse? result) async {
                  emit(PostCallCustomerSuccessState(
                    callId: result,
                    phoneIndex: event.phoneIndex,
                    customerIndex: event.customerIndex,
                  ));
                }, failure: (NetworkExceptions? error) async {
                  print("Error ${error}");
                  emit(PostCallCustomerFailureState());
                });
              } else {
                emit(PhoneIndexLesserThanTempMobileListEvent());
              }
            }
          }
        }
      }, failure: (NetworkExceptions? error) async {
        emit(GetAgencyDetailsFailureState());
      });
    }

    if (event is UpdateNewValuesEvent) {
      // resultList.asMap().forEach((index, value) {
      //   if (value.caseId == event.paramValue) {
      //     if (Singleton.instance.usertype == Constants.telecaller) {
      //       value.telSubStatus = event.selectedClipValue;
      //     } else {
      //       value.collSubStatus = event.selectedClipValue;
      //     }
      //     if (event.selectedClipValue != null && event.followUpDate != null) {
      //       value.followUpDate = event.followUpDate;
      //     }
      //   }
      // });
      emit(UpdateNewValueState(
          selectedEventValue: event.selectedClipValue,
          updateFollowUpdate: event.followUpDate,
          paramValue: event.paramValue));
    }

    if (event is MessageEvent) {
      emit(MessageState());
    }

    if (event is FilterSelectOptionEvent) {
      emit(FilterSelectOptionState());
    }
    // if (event is SearchReturnDataEvent) {
    //   yield CaseListViewLoadingState();
    //
    //   if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
    //     yield NoInternetConnectionState();
    //   } else {
    //     final data = event.returnValue as SearchingDataModel;
    //     Map<String, dynamic> getSearchResultData;
    //     if (data.isStarCases! && data.isMyRecentActivity!) {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           '${HttpUrl.searchUrl}starredOnly=${data.isStarCases}&recentActivity=${data.isMyRecentActivity}&accNo=${data.accountNumber}&cust=${data.customerName}&bankName=${data.bankName}&dpdStr=${data.dpdBucket}&customerId=${data.customerID}&pincode=${data.pincode}&collSubStatus=${data.status}',
    //           encrypt: true);
    //     } else if (data.isStarCases!) {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           '${HttpUrl.searchUrl}starredOnly=${data.isStarCases}&accNo=${data.accountNumber}&cust=${data.customerName}&bankName=${data.bankName}&dpdStr=${data.dpdBucket}&customerId=${data.customerID}&pincode=${data.pincode}&collSubStatus=${data.status}',
    //           encrypt: true);
    //     } else if (data.isMyRecentActivity!) {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           '${HttpUrl.searchUrl}recentActivity=${data.isMyRecentActivity}&accNo=${data.accountNumber}&cust=${data.customerName}&bankName=${data.bankName}&dpdStr=${data.dpdBucket}&customerId=${data.customerID}&pincode=${data.pincode}&collSubStatus=${data.status}',
    //           encrypt: true);
    //     } else {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           '${HttpUrl.searchUrl}accNo=${data.accountNumber}&cust=${data.customerName}&bankName=${data.bankName}&dpdStr=${data.dpdBucket}&customerId=${data.customerID}&pincode=${data.pincode}&collSubStatus=${data.status}',
    //           encrypt: true);
    //     }
    //
    //     resultListBloc.clear();
    //     starCount = 0;
    //
    //     for (var element in getSearchResultData['data']['result']) {
    //       resultListBloc.add(Result.fromJson(jsonDecode(jsonEncode(element))));
    //       if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
    //           true) {
    //         starCount++;
    //       }
    //     }
    //
    //     isShowSearchPincode = true;
    //     selectedOption = 3;
    //     showFilterDistance = false;
    //   }
    //   yield SearchReturnDataState();
    // }

    if (event is ShowAutoCallingEvent) {
      emit(AutoCallingLoadingState());
      customerCount = 0;
      isAutoCalling = true;
      isShowSearchFloatingButton = false;

      final autoCallingListData = await caseRepository.getAutoCallingListData();
      await autoCallingListData.when(
          success: (List<PriorityCaseListModel>? result) async {
            if (result?.isNotEmpty == true && result != null) {
              autoCallingResultList.clear();

              result.forEach((element) {
                autoCallingResultList.add(element);
              });

              // totalCount = result.totalCases;
              for (var element in autoCallingResultList) {
                element.address?.removeWhere((element) =>
                    (element.cType == 'office address' ||
                        element.cType == 'residence address' ||
                        element.cType == 'email'));
              }
            }
          },
          failure: (NetworkExceptions? error) async {});

      emit(AutoCallingLoadedState());
    }
    if (event is AutoCallingContactSortEvent) {
      emit(AutoCallingContactSortState());
    }

    if (event is AutoCallContactHealthUpdateEvent) {
      emit(AutoCallContactHealthUpdateState(
          contactIndex: event.contactIndex, caseIndex: event.caseIndex));
    }
  }

  //todo plugin for configurable google map services

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  Future<void> _setGoogleMapApiKey(String mapKey) async {
    final Map<String, dynamic> requestData = {'mapKey': mapKey};
    await platform.invokeMethod('setGoogleMapKey', requestData).then((value) {
      // getLocation();
    });
  }
}
