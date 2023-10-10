import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:design_system/constant_event_values.dart';
import 'package:design_system/constants.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:domain_models/request_body/allocation/are_you_at_office_model.dart';
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

      emit(UpdateStaredCaseState(
          caseId: event.caseID,
          isStared: resultList[event.selectedStarIndex].starredCase,
          selectedIndex: event.selectedStarIndex));
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
