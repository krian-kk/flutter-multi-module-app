import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/models/auto_calling_model.dart';
import 'package:origa/models/contractor_detail_model.dart';
import 'package:origa/models/contractor_information_model.dart';
import 'package:origa/models/offline_priority_response_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'allocation_event.dart';

part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc({AuthenticationBloc? authBloc}) : super(AllocationInitial());

  // AllocationBloc() : super(AllocationInitial());

  bool isOfflineTriggered = false;
  int selectedOption = 0;

  int customerCount = 0;
  int totalCount = 0;
  int tempTotalCount = 0;

  String? userType;
  String? agentName;
  String? agrRef;

  int indexValue = 0;

  String? selectedDistance;

  bool areyouatOffice = true;

  bool showFilterDistance = false;
  bool isShowSearchPincode = false;

  // it's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? isNoInternetAndServerErrorMsg = '';

  int? messageCount = 0;
  bool isMessageThere = false;

  int page = 1;

  // There is used for pagination to scroll up
  bool hasNextPage = false;

  // Show Telecaller Autocalling
  bool isAutoCalling = false;

  // Enable or Disable the search floating button
  bool isShowSearchFloatingButton = true;

  // Check which event to call for load more cases
  bool isPriorityLoadMore = false;

  List<String> selectOptions = <String>[];
  List<AutoCallingModel> mobileNumberList = <AutoCallingModel>[];

  List<String> filterBuildRoute = <String>[
    // StringResource.all,
    // StringResource.under5km,
    // StringResource.more5km,
  ];

  List<AllocationListModel> allocationList = <AllocationListModel>[];
  late Position currentLocation;
  List<dynamic> multipleLatLong = <dynamic>[];

  int starCount = 0;
  int totalCases = 0;
  List<Result> resultList = <Result>[];
  List<Result> autoCallingResultList = <Result>[];
  ContractorDetailsModel contractorDetailsValue = ContractorDetailsModel();

  int? selectedStar;

  @override
  Stream<AllocationState> mapEventToState(AllocationEvent event) async* {
    if (event is AllocationInitialEvent) {
      if (!event.isOfflineAPI) {
        yield AllocationLoadingState();
      }
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      Singleton.instance.buildContext = event.context;
      userType = _pref.getString(Constants.userType);
      agentName = _pref.getString(Constants.agentName);
      agrRef = _pref.getString(Constants.agentRef);
      isShowSearchPincode = false;
      selectedDistance = Languages.of(event.context)!.all;

      // check in office location captured or not
      areyouatOffice = _pref.getBool('areyouatOffice') ?? true;

      // Here find FIELDAGENT or TELECALLER and set in allocation screen
      if (userType == Constants.fieldagent) {
        selectOptions = [
          Languages.of(event.context)!.priority,
          Languages.of(event.context)!.buildRoute,
          Languages.of(event.context)!.mapView,
        ];
      } else {
        selectOptions = [
          Languages.of(event.context)!.priority,
          Languages.of(event.context)!.autoCalling,
        ];
        areyouatOffice = false;
      }

      filterBuildRoute = [
        Languages.of(event.context)!.all,
        Languages.of(event.context)!.under5km,
        Languages.of(event.context)!.more5km,
      ];
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        isNoInternetAndServerErrorMsg =
            Languages.of(event.context)!.noInternetConnection;
        yield AllocationOfflineState(successResponse: 'offlineData');
      } else {
        final SharedPreferences _pref = await SharedPreferences.getInstance();
        // if (_pref.getBool(Constants.appDataLoadedFromFirebase) == true) {
        //   debugPrint('Values--> in off initiateState');
        //   yield AllocationOfflineState(successResponse: "offlineData");
        // } else {
        isNoInternetAndServerError = false;
        // Now set priority case is a load more event
        isPriorityLoadMore = true;

        //event.isOfflineAPI! For offline purpose only
        final Map<String, dynamic> priorityListData =
            await APIRepository.apiRequest(
                APIRequestType.get,
                event.isOfflineAPI == true
                    ? HttpUrl.priorityCaseListV2
                    : HttpUrl.priorityCaseListV1 +
                        'pageNo=${Constants.pageNo}' +
                        '&limit=${Constants.limit}');

        resultList.clear();
        starCount = 0;
        if (priorityListData['success']) {
          dynamic offlinePriorityResponseModel;
          try {
            offlinePriorityResponseModel =
                OfflinePriorityResponseModel.fromJson(priorityListData['data']);
          } catch (e) {
            yield AllocationLoadedState(successResponse: '');
            debugPrint(e.toString());
          }
          if (offlinePriorityResponseModel is OfflinePriorityResponseModel) {
            hasNextPage = true;
            await FirebaseFirestore.instance
                .collection(Singleton.instance.firebaseDatabaseName)
                .doc(Singleton.instance.agentRef)
                .collection(Constants.firebaseCase)
                .get()
                .then((value) {
              for (var element in value.docs) {
                // try {
                //   debugPrint(
                //       'Result items--> ${Result.fromJson(jsonDecode(jsonEncode(element.data()))).caseId}');
                // } catch (e) {
                //   debugPrint('Catch items--> ${e.toString()}');
                // }
                // debugPrint('Allocation items--> ${value.docs.length + 1}');
              }
              AppUtils.showToast('App synced with local');
            });
            isOfflineTriggered = true;
            totalCases = 0;
            await _pref.setBool(Constants.appDataLoadedFromFirebase, true);
            await _pref.setString(Constants.appDataLoadedFromFirebaseTime,
                DateTime.now().toString());
          } else {
            for (var element in priorityListData['data']['result']) {
              resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
              if (Result.fromJson(jsonDecode(jsonEncode(element)))
                      .starredCase ==
                  true) {
                starCount++;
              }
            }
            if (priorityListData['data']['totalCases'] != null) {
              totalCases = priorityListData['data']['totalCases'] as int;
            }
            if (resultList.length >= 10) {
              hasNextPage = true;
            } else {
              hasNextPage = false;
            }
            // Get Contractor Details and stored in Singleton
            final Map<String, dynamic> getContractorDetails =
                await APIRepository.apiRequest(
                    APIRequestType.get, HttpUrl.contractorDetail);
            if (getContractorDetails[Constants.success] == true) {
              final Map<String, dynamic> jsonData =
                  getContractorDetails['data'];
              // check and store cloudTelephony true or false
              Singleton.instance.cloudTelephony =
                  jsonData['result']['cloudTelephony'] ?? false;
              Singleton.instance.feedbackTemplate =
                  ContractorDetailsModel.fromJson(jsonData);
              Singleton.instance.contractorInformations =
                  ContractorAllInformationModel.fromJson(jsonData);

              // if cloudTelephone false means dont show autoCalling tab
              if (jsonData['result']['cloudTelephony'] == false) {
                if (userType == Constants.telecaller) {
                  selectOptions = [
                    Languages.of(event.context)!.priority,
                    // Languages.of(event.context)!.autoCalling,
                  ];
                }
              }
            } else {
              if (getContractorDetails['data'] != null) {
                AppUtils.showToast(getContractorDetails['data'] ?? '');
              }
            }
            yield AllocationLoadedState(successResponse: resultList);
            //if with offline release
            if (Singleton.instance.isMPin) {
              if (userType == Constants.fieldagent && !isOfflineTriggered) {
                final bool isOfflineExisitingInThisDevice =
                    _pref.getBool(Constants.appDataLoadedFromFirebase) ?? false;
                if (!isOfflineExisitingInThisDevice) {
                  await FirebaseFirestore.instance.terminate();
                  add(AllocationInitialEvent(event.context,
                      isOfflineAPI: true));
                }
              }
            }
          }
        } else if (priorityListData['statusCode'] == 401 ||
            priorityListData['data'] == Constants.connectionTimeout ||
            priorityListData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          isNoInternetAndServerErrorMsg = priorityListData['data'];
          yield AllocationLoadedState(successResponse: resultList);
        }
        // }
      }
    }
    if (event is TapPriorityEvent) {
      yield CaseListViewLoadingState();

      page = 1;
      // hasNextPage = true;
      // Enable the search and hide autocalling screen
      isAutoCalling = false;
      isShowSearchFloatingButton = true;
      Singleton.instance.startCalling = false;
      // Now set priority case is a load more event
      isPriorityLoadMore = true;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        final Map<String, dynamic> priorityListData =
            await APIRepository.apiRequest(
                APIRequestType.get,
                HttpUrl.priorityCaseListV1 +
                    'pageNo=${Constants.pageNo}' +
                    '&limit=${Constants.limit}');

        resultList.clear();
        starCount = 0;

        for (var element in priorityListData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount++;
          }
        }

        if (resultList.length >= 10) {
          hasNextPage = true;
        } else {
          hasNextPage = false;
        }
      }

      yield TapPriorityState(successResponse: resultList);
    }
    if (event is ConnectedStopAndSubmitEvent) {
      final Result val = autoCallingResultList[event.customerIndex];
      autoCallingResultList.remove(val);
      customerCount++;
    }
    if (event is StartCallingEvent) {
      if (event.isIncreaseCount && event.customerIndex! <= totalCount) {
        final Result val = autoCallingResultList[event.customerIndex! - 1];
        autoCallingResultList.remove(val);
        // autoCallingResultList.add(val);
        customerCount++;
        yield UpdateNewValueState();
      }
      Singleton.instance.startCalling = true;

      yield StartCallingState(
        customerIndex: event.isIncreaseCount
            ? event.customerIndex! - 1
            : event.customerIndex!,
        phoneIndex: event.phoneIndex,
      );
    }
    if (event is PriorityLoadMoreEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        final Map<String, dynamic> priorityListData =
            await APIRepository.apiRequest(
                APIRequestType.get,
                HttpUrl.priorityCaseListV1 +
                    'pageNo=$page' +
                    '&limit=${Constants.limit}');
        final PriorityCaseListModel listOfdata =
            PriorityCaseListModel.fromJson(priorityListData['data']);
        if (priorityListData['data']['result'] != null) {
          for (var element in priorityListData['data']['result']) {
            resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
            if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
                true) {
              starCount++;
            }
          }

          ///Chaecking the result length >= 10 for load more data
          if (listOfdata.result!.length >= 10) {
            hasNextPage = true;
          } else {
            hasNextPage = false;
          }
        } else {}
      }
      yield PriorityLoadMoreState(successResponse: resultList);
    }
    if (event is CallSuccessfullyConnectedEvent) {
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      int index;
      index = _pref.getInt('autoCallingIndexValue') ?? 0;
      indexValue = index;
      await _pref.setInt('autoCallingIndexValue', index + 1);
      if (Singleton.instance.startCalling ?? false) {
        yield StartCallingState();
      }
    }
    if (event is CallUnSuccessfullyConnectedEvent) {
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      int index, subIndex;
      index = _pref.getInt('autoCallingIndexValue') ?? 0;
      subIndex = _pref.getInt('autoCallingSubIndexValue') ?? 0;
      await _pref.setInt('autoCallingIndexValue', index + 1);
      await _pref.setInt('autoCallingSubIndexValue', subIndex + 1);
      if (Singleton.instance.startCalling ?? false) {
        yield StartCallingState();
      }
    }
    if (event is TapBuildRouteEvent) {
      yield CaseListViewLoadingState();
      page = 1;
      // hasNextPage = true;
      // Now set Build Route case is a load more event
      isPriorityLoadMore = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        final Map<String, dynamic> buildRouteListData =
            await APIRepository.apiRequest(
                APIRequestType.get,
                HttpUrl.buildRouteCaseList +
                    'lat=${event.paramValues.lat}&' +
                    'lng=${event.paramValues.long}&' +
                    'maxDistMeters=${event.paramValues.maxDistMeters}&' +
                    'page=${Constants.pageNo}&' +
                    'limit=${Constants.limit}');

        resultList.clear();
        multipleLatLong.clear();
        buildRouteListData['data']['result']['cases'].forEach((element) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          final Result listOfCases =
              Result.fromJson(jsonDecode(jsonEncode(element)));
          multipleLatLong.add(
            MapMarkerModel(
              caseId: listOfCases.caseId,
              address: listOfCases.address?.first.value,
              due: listOfCases.due.toString(),
              name: listOfCases.cust,
              latitude: listOfCases.location?.lat,
              longitude: listOfCases.location?.lng,
            ),
          );
        });

        ///checking list if case length becoz of loaD more data
        if (resultList.length >= 10) {
          hasNextPage = true;
        } else {
          hasNextPage = false;
        }
      }
      yield TapBuildRouteState(successResponse: resultList);
    }
    if (event is BuildRouteLoadMoreEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        final Map<String, dynamic> buildRouteListData =
            await APIRepository.apiRequest(
                APIRequestType.get,
                HttpUrl.buildRouteCaseList +
                    'lat=${event.paramValues.lat}&' +
                    'lng=${event.paramValues.long}&' +
                    'maxDistMeters=${event.paramValues.maxDistMeters}&' +
                    'page=$page&' +
                    'limit=${Constants.limit}');
        final PriorityCaseListModel listOfdata =
            PriorityCaseListModel.fromJson(buildRouteListData['data']);
        buildRouteListData['data']['result']['cases'].forEach((element) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          final Result listOfCases =
              Result.fromJson(jsonDecode(jsonEncode(element)));
          multipleLatLong.add(
            MapMarkerModel(
              caseId: listOfCases.caseId,
              address: listOfCases.address?.first.value,
              due: listOfCases.due.toString(),
              name: listOfCases.cust,
              latitude: listOfCases.location?.lat,
              longitude: listOfCases.location?.lng,
            ),
          );
        });

        ///Chaecking the result length >= 10 for load more data
        if (listOfdata.result!.length >= 10) {
          hasNextPage = true;
        } else {
          hasNextPage = false;
        }
      }
      yield BuildRouteLoadMoreState(successResponse: resultList);
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
      yield UpdateNewValueState(
          selectedEventValue: event.selectedClipValue,
          updateFollowUpdate: event.followUpDate,
          paramValue: event.paramValue);
    }
    if (event is MapViewEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        yield MapInitiateState();
        final Map<String, dynamic> buildRouteListData =
            await APIRepository.apiRequest(
                APIRequestType.get,
                HttpUrl.buildRouteCaseList +
                    'lat=${event.paramValues.lat}&' +
                    'lng=${event.paramValues.long}&' +
                    'maxDistMeters=${event.paramValues.maxDistMeters}&' +
                    'page=${Constants.pageNo}&' +
                    'limit=${Constants.limit}');

        buildRouteListData['data']['result']['cases'].forEach((element) {
          final Result listOfCases =
              Result.fromJson(jsonDecode(jsonEncode(element)));
          multipleLatLong.add(
            MapMarkerModel(
              caseId: listOfCases.caseId,
              address: listOfCases.address?.first.value,
              due: listOfCases.due.toString(),
              name: listOfCases.cust,
              latitude: listOfCases.location?.lat,
              longitude: listOfCases.location?.lng,
            ),
          );
        });
      }
      yield MapViewState();
    }
    if (event is TapAreYouAtOfficeOptionsEvent) {
      yield TapAreYouAtOfficeOptionsState();
    }
    if (event is MessageEvent) {
      yield MessageState();
    }
    if (event is NavigateSearchPageEvent) {
      yield NavigateSearchPageState();
    }
    if (event is NavigateCaseDetailEvent) {
      yield NavigateCaseDetailState(paramValues: event.paramValues);
    }
    if (event is FilterSelectOptionEvent) {
      yield FilterSelectOptionState();
    }
    if (event is SearchReturnDataEvent) {
      yield CaseListViewLoadingState();

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        final data = event.returnValue as SearchingDataModel;
        Map<String, dynamic> getSearchResultData;
        if (data.isStarCases! && data.isMyRecentActivity!) {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.get,
              HttpUrl.searchUrl +
                  'starredOnly=${data.isStarCases}&' +
                  'recentActivity=${data.isMyRecentActivity}&' +
                  'accNo=${data.accountNumber}&' +
                  'cust=${data.customerName}&' +
                  'dpdStr=${data.dpdBucket}&' +
                  'customerId=${data.customerID}&' +
                  'pincode=${data.pincode}&' +
                  'collSubStatus=${data.status}');
        } else if (data.isStarCases!) {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.get,
              HttpUrl.searchUrl +
                  'starredOnly=${data.isStarCases}&' +
                  'accNo=${data.accountNumber}&' +
                  'cust=${data.customerName}&' +
                  'dpdStr=${data.dpdBucket}&' +
                  'customerId=${data.customerID}&' +
                  'pincode=${data.pincode}&' +
                  'collSubStatus=${data.status}');
        } else if (data.isMyRecentActivity!) {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.get,
              HttpUrl.searchUrl +
                  'recentActivity=${data.isMyRecentActivity}&' +
                  'accNo=${data.accountNumber}&' +
                  'cust=${data.customerName}&' +
                  'dpdStr=${data.dpdBucket}&' +
                  'customerId=${data.customerID}&' +
                  'pincode=${data.pincode}&' +
                  'collSubStatus=${data.status}');
        } else {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.get,
              HttpUrl.searchUrl +
                  'accNo=${data.accountNumber}&' +
                  'cust=${data.customerName}&' +
                  'dpdStr=${data.dpdBucket}&' +
                  'customerId=${data.customerID}&' +
                  'pincode=${data.pincode}&' +
                  'collSubStatus=${data.status}');
        }

        resultList.clear();
        starCount = 0;

        for (var element in getSearchResultData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount++;
          }
        }

        isShowSearchPincode = true;
        selectedOption = 3;
        showFilterDistance = false;
      }
      yield SearchReturnDataState();
    }
    if (event is ShowAutoCallingEvent) {
      yield AutoCallingLoadingState();
      customerCount = 0;
      isAutoCalling = true;
      isShowSearchFloatingButton = false;

      final Map<String, dynamic> autoCallingListData =
          await APIRepository.apiRequest(
        APIRequestType.get,
        HttpUrl.autoCallingURL,
      );
      autoCallingResultList.clear();
      if (autoCallingListData[Constants.success] == true) {
        for (var element in autoCallingListData['data']['result']) {
          autoCallingResultList
              .add(Result.fromJson(jsonDecode(jsonEncode(element))));
        }
      }
      // autoCallingResultList.clear();
      // autoCallingResultList = resultList;
      totalCount = autoCallingResultList.length;
      for (var element in autoCallingResultList) {
        element.address?.removeWhere((element) =>
            (element.cType == 'office address' ||
                element.cType == 'residence address' ||
                element.cType == 'email'));
      }
      yield AutoCallingLoadedState();
    }
    if (event is AutoCallingContactSortEvent) {
      yield AutoCallingContactSortState();
    }
    if (event is UpdateStaredCaseEvent) {
      Singleton.instance.buildContext = event.context;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        final SharedPreferences _pref = await SharedPreferences.getInstance();
        if (_pref.getString(Constants.userType) == Constants.fieldagent) {
          resultList[event.selectedStarIndex].starredCase =
              !resultList[event.selectedStarIndex].starredCase;
        } else {
          yield NoInternetConnectionState();
        }
      } else {
        resultList[event.selectedStarIndex].starredCase =
            !resultList[event.selectedStarIndex].starredCase;
      }

      yield UpdateStaredCaseState(
          caseId: event.caseID,
          isStared: resultList[event.selectedStarIndex].starredCase,
          selectedIndex: event.selectedStarIndex);
    }
    if (event is AutoCallContactHealthUpdateEvent) {
      yield AutoCallContactHealthUpdateState(
          contactIndex: event.contactIndex, caseIndex: event.caseIndex);
    }
  }
}
