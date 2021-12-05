import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/models/build_route_model/build_route_model.dart';
import 'package:origa/models/buildroute_data.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/search_model/search_model.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/offline_helper/dynamic_table.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/string_resource.dart';

part 'allocation_event.dart';
part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc() : super(AllocationInitial());

  int selectedOption = 0;

  BuildRouteModel buildRouteData = BuildRouteModel();

  String selectedDistance = StringResource.all;

  SearchModel searchData = SearchModel();

  bool showFilterDistance = false;
  bool isShowSearchPincode = false;
  bool isNoInternet = false;

  List<String> selectOptions = [
    StringResource.priority,
    StringResource.buildRoute,
    StringResource.mapView,
  ];

  List<String> filterBuildRoute = [
    StringResource.all,
    StringResource.under5km,
    StringResource.more5km,
  ];

  List<AllocationListModel> allocationList = [];
  late Position currentLocation;

  // Future<Box<OrigoDynamicTable>> offlineDatabaseBox =
  //     Hive.openBox<OrigoDynamicTable>('testBox4');

  AllocationListModel searchResultData = AllocationListModel();
  List starCount = [];
  List<Result> resultList = [];

  @override
  Stream<AllocationState> mapEventToState(AllocationEvent event) async* {
    if (event is AllocationInitialEvent) {
      yield AllocationLoadingState();
      isShowSearchPincode = false;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternet = true;
        yield NoInternetConnectionState();
      } else {
        isNoInternet = false;
        // print(APIRepository.getpriorityCaseList());
        // Map<String, dynamic> priorityListData = await APIRepository.getpriorityCaseList();
        Map<String, dynamic> priorityListData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.priorityCaseList);

        resultList.clear();
        starCount.clear();

        for (var element in priorityListData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount.add(
                Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
          }
        }

        // offlineDatabaseBox.whenComplete(() {
        //   offlineDatabaseBox.then((value) {
        //         value.put('priority_caselist',
        //         OrigoDynamicTable(
        //           message: priorityListData['message'],
        //           status: priorityListData['status'],
        //           result: priorityListData['result'] as List<dynamic>,
        //         ),
        //       );
        //       for (var element in value.get('priority_caselist')!.result) {
        //         resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
        //         if (Result.fromJson(jsonDecode(jsonEncode(element)))
        //                 .starredCase ==
        //             true) {
        //           starCount.add(Result.fromJson(jsonDecode(jsonEncode(element)))
        //               .starredCase);
        //         }
        //       }
        //     });
        //   });
      }
      // else {
      //   await offlineDatabaseBox.then((value) {
      //     for (var element in value.get('priority_caselist')!.result) {
      //       resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
      //       if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
      //           true) {
      //         starCount.add(
      //             Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
      //       }
      //     }
      //   });
      // }
      yield AllocationLoadedState(successResponse: resultList);
    }

    if (event is TapPriorityEvent) {
      yield CaseListViewLoadingState();

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // print(APIRepository.getpriorityCaseList());
        // Map<String, dynamic> priorityListData = await APIRepository.getpriorityCaseList();
        Map<String, dynamic> priorityListData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.priorityCaseList);

        resultList.clear();
        starCount.clear();

        for (var element in priorityListData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount.add(
                Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
          }
        }
      }
      yield TapPriorityState(successResponse: resultList);
    }

    if (event is TapBuildRouteEvent) {
      yield CaseListViewLoadingState();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // print(APIRepository.getpriorityCaseList());
        // Map<String, dynamic> buildRouteListData = await APIRepository.getBuildRouteCaseList();
        Map<String, dynamic> buildRouteListData =
            await APIRepository.apiRequest(
                APIRequestType.GET,
                HttpUrl.buildRouteCaseList +
                    "lat=${event.paramValues.lat}&" +
                    "lng=${event.paramValues.long}&" +
                    "maxDistMeters=${event.paramValues.maxDistMeters}");
        print(buildRouteListData);

        resultList.clear();
        starCount.clear();

        for (var element in buildRouteListData['data']['result']['cases']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount.add(
                Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
          }
        }
      }
      yield TapBuildRouteState(successResponse: resultList);
    }

    if (event is MapViewEvent) {
      yield MapViewState();
    }

    if (event is MessageEvent) {
      yield MessageState();
    }

    if (event is NavigateSearchPageEvent) {
      yield NavigateSearchPageState();
    }

    if (event is NavigateCaseDetailEvent) {
      // print('event.paramValues---');
      // print(event.paramValues);
      yield NavigateCaseDetailState(paramValues: event.paramValues);
    }

    if (event is FilterSelectOptionEvent) {
      yield FilterSelectOptionState();
      // selectedOption = 0;
    }

    if (event is SearchReturnDataEvent) {
      yield CaseListViewLoadingState();

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        // if(event.returnValue is SearchingDataModel){
        //   print('Print in bloc--> ${event.returnValue}');
        //  }
        Map<String, dynamic> getSearchResultData =
            await APIRepository.apiRequest(
                APIRequestType.GET,
                HttpUrl.searchUrl +
                    "starredOnly=${event.returnValue.isStarCases}&" +
                    "recentActivity=${event.returnValue.isMyRecentActivity}&" +
                    "accNo=${event.returnValue.accountNumber}&" +
                    "cust=${event.returnValue.customerName}&" +
                    "dpdStr=${event.returnValue.dpdBucket}&" +
                    "customerId=${event.returnValue.customerID}&" +
                    "pincode=${event.returnValue.pincode}&" +
                    "collSubStatus=${event.returnValue.status}");
        print('getSearchResultData----->');
        print(getSearchResultData);
        resultList.clear();
        starCount.clear();

        for (var element in getSearchResultData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount.add(
                Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
          }
        }

        isShowSearchPincode = true;
        selectedOption = 3;
        showFilterDistance = false;
      }
      yield SearchReturnDataState();
    }
  }
}
