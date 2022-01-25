import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/models/auto_calling_model.dart';
import 'package:origa/models/contractor_detail_model.dart';
// import 'package:origa/models/build_route_model/build_route_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/search_model/search_model.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'allocation_event.dart';
part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc() : super(AllocationInitial());

  int selectedOption = 0;

  String? userType;
  String? agentName;
  String? agrRef;

  int indexValue = 0;

  // BuildRouteModel buildRouteData = BuildRouteModel();

  String selectedDistance = StringResource.all;

  // SearchModel searchData = SearchModel();
  bool areyouatOffice = true;

  bool showFilterDistance = false;
  bool isShowSearchPincode = false;

  // it's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? isNoInternetAndServerErrorMsg = '';

  int? messageCount = 0;
  bool isMessageThere = false;

  int page = 1;

  // There is next page or not
  bool hasNextPage = true;
  // Show Telecaller Autocalling
  bool isAutoCalling = false;
  // Enable or Disable the search floating button
  bool isShowSearchFloatingButton = true;
  // Check which event to call for load more cases
  bool isPriorityLoadMore = false;

  List<String> selectOptions = [];
  List<AutoCallingModel> mobileNumberList = [];

  List<String> filterBuildRoute = [
    StringResource.all,
    StringResource.under5km,
    StringResource.more5km,
  ];

  List<AllocationListModel> allocationList = [];
  late Position currentLocation;

  // Future<Box<OrigoDynamicTable>> offlineDatabaseBox =
  //     Hive.openBox<OrigoDynamicTable>('testBox4');

  // AllocationListModel searchResultData = AllocationListModel();
  List starCount = [];
  // List priorityCaseAddressList = [];
  List<Result> resultList = [];
  ContractorDetailsModel contractorDetailsValue = ContractorDetailsModel();

  @override
  Stream<AllocationState> mapEventToState(AllocationEvent event) async* {
    if (event is AllocationInitialEvent) {
      yield AllocationLoadingState();
      SharedPreferences _pref = await SharedPreferences.getInstance();
      // _pref.setString(Constants.buildcontext, event.context.toString());
      Singleton.instance.buildContext = event.context;
      userType = _pref.getString(Constants.userType);
      agentName = _pref.getString(Constants.agentName);
      agrRef = _pref.getString(Constants.agentRef);
      isShowSearchPincode = false;

      // check in office location captured or not
      areyouatOffice = _pref.getBool('areyouatOffice') ?? true;

      // Here find FIELDAGENT or TELECALLER and set in allocation screen
      if (userType == Constants.fieldagent) {
        selectOptions = [
          StringResource.priority,
          StringResource.buildRoute,
          StringResource.mapView,
        ];
      } else {
        selectOptions = [
          StringResource.priority,
          StringResource.autoCalling,
        ];
        areyouatOffice = false;
      }

      // static Autocalling Values
      mobileNumberList.addAll([
        AutoCallingModel(
          mobileNumber: '6374578994',
          callResponse: 'Declined Call',
        ),
        AutoCallingModel(
          mobileNumber: '9342536805',
        ),
        AutoCallingModel(
          mobileNumber: '6374578994',
        ),
      ]);

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        isNoInternetAndServerErrorMsg =
            Languages.of(event.context)!.noInternetConnection;
        yield NoInternetConnectionState();
      } else {
        isNoInternetAndServerError = false;
        // Now set priority case is a load more event
        isPriorityLoadMore = true;

        Map<String, dynamic> priorityListData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.priorityCaseList +
                'pageNo=${Constants.pageNo}' +
                '&limit=${Constants.limit}'
            //  +"&userType=$userType",
            );

        resultList.clear();
        starCount.clear();

        if (priorityListData['success']) {
          for (var element in priorityListData['data']['result']) {
            resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
            if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
                true) {
              starCount.add(
                  Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
            }

            // Here add the address its used for make view map show the mark for case location
            // if (userType == Constants.fieldagent) {
            //   if (Result.fromJson(jsonDecode(jsonEncode(element)))
            //           .address![0]
            //           .cType ==
            //       "residence address") {
            //     // And here checked for already addres added or not
            //     if (priorityCaseAddressList.contains(
            //         Result.fromJson(jsonDecode(jsonEncode(element)))
            //             .address![0]
            //             .value)) {
            //       print("already added");
            //     } else {
            //       print("newly added");
            //       priorityCaseAddressList.add(
            //           Result.fromJson(jsonDecode(jsonEncode(element)))
            //               .address![0]
            //               .value
            //           // ?.splitMapJoin(' ')
            //           );
            //     }
            //   }
            // }
          }
          // Get Contractor Details
          Map<String, dynamic> getContractorDetails =
              await APIRepository.apiRequest(
                  APIRequestType.GET, HttpUrl.contractorDetail);
          if (getContractorDetails[Constants.success] == true) {
            Map<String, dynamic> jsonData = getContractorDetails['data'];
            Singleton.instance.cloudTelephony =
                jsonData['result']['cloudTelephony'] ?? false;
            Singleton.instance.feedbackTemplate =
                ContractorDetailsModel.fromJson(jsonData);
            // contractorDetailsValue = ContractorDetailsModel.fromJson(jsonData);
          } else {
            AppUtils.showToast(getContractorDetails['data'] ?? '');
            // AppUtils.showToast(getContractorDetails['data']);
          }
        } else if (priorityListData['statusCode'] == 401 ||
            priorityListData['data'] == Constants.connectionTimeout ||
            priorityListData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          isNoInternetAndServerErrorMsg = priorityListData['data'];
          // print('------Api not working----------');
          // print(priorityListData['data']);
        }
      }

      yield AllocationLoadedState(successResponse: resultList);
    }

    if (event is TapPriorityEvent) {
      yield CaseListViewLoadingState();

      page = 1;
      hasNextPage = true;
      // Enable the search and hide autocalling screen
      isAutoCalling = false;
      isShowSearchFloatingButton = true;
      // Now set priority case is a load more event
      isPriorityLoadMore = true;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> priorityListData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.priorityCaseList +
                'pageNo=${Constants.pageNo}' +
                '&limit=${Constants.limit}');

        resultList.clear();
        starCount.clear();

        for (var element in priorityListData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount.add(
                Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
          }
          //Tap again priority so, Here add the address its used for make view map show the mark for case location
          // if (userType == Constants.fieldagent) {
          //   if (Result.fromJson(jsonDecode(jsonEncode(element)))
          //           .address![0]
          //           .cType ==
          //       "residence address") {
          //     // And here checked for already addres added or not
          //     if (priorityCaseAddressList.contains(
          //         Result.fromJson(jsonDecode(jsonEncode(element)))
          //             .address![0]
          //             .value)) {
          //       print("already added");
          //     } else {
          //       print("newly added");
          //       priorityCaseAddressList.add(
          //           Result.fromJson(jsonDecode(jsonEncode(element)))
          //               .address![0]
          //               .value);
          //     }
          //   }
          // }
        }
      }

      yield TapPriorityState(successResponse: resultList);
    }
    if (event is StartCallingEvent) {
      print(event.customerIndex);
      print(event.phoneIndex);
      print(event.customerList);
      Singleton.instance.startCalling = true;
      // yield* Stream.periodic(
      //     const Duration(seconds: 45),
      //     (index) => StartCallingState(
      //           customerIndex: event.customerIndex,
      //           // customerList: event.customerList,
      //           phoneIndex: event.phoneIndex,
      //         ));
      yield StartCallingState(
        customerIndex: event.customerIndex,
        // customerList: event.customerList,
        phoneIndex: event.phoneIndex,
      );
    }

    if (event is PriorityLoadMoreEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> priorityListData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.priorityCaseList +
                'pageNo=$page' +
                '&limit=${Constants.limit}');
        if (priorityListData['data']['result'] != null) {
          for (var element in priorityListData['data']['result']) {
            resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
            if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
                true) {
              starCount.addAll(Result.fromJson(jsonDecode(jsonEncode(element)))
                  .starredCase as List);
            }
            //Load more priority list so, Here add the address its used for make view map show the mark for case location
            // if (userType == Constants.fieldagent) {
            //   if (Result.fromJson(jsonDecode(jsonEncode(element)))
            //           .address![0]
            //           .cType ==
            //       "residence address") {
            //     // And here checked for already addres added or not
            //     if (priorityCaseAddressList.contains(
            //         Result.fromJson(jsonDecode(jsonEncode(element)))
            //             .address![0]
            //             .value)) {
            //       print("already added");
            //     } else {
            //       print("newly added");
            //       priorityCaseAddressList.add(
            //           Result.fromJson(jsonDecode(jsonEncode(element)))
            //               .address![0]
            //               .value);
            //     }
            //   }
            // }
          }
        } else {
          // hasNextPage = false;
        }
      }
      yield PriorityLoadMoreState(successResponse: resultList);
    }

    if (event is CallSuccessfullyConnectedEvent) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      int index;
      index = _pref.getInt('autoCallingIndexValue') ?? 0;
      indexValue = index;
      _pref.setInt('autoCallingIndexValue', index + 1);
      print(Singleton.instance.startCalling);
      if (Singleton.instance.startCalling ?? false) {
        print(Singleton.instance.startCalling.toString() + 'jdlj');
        yield StartCallingState();
        print('ddldk');
      }
    }
    if (event is CallUnSuccessfullyConnectedEvent) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      int index, subIndex;
      index = _pref.getInt('autoCallingIndexValue') ?? 0;
      subIndex = _pref.getInt('autoCallingSubIndexValue') ?? 0;
      _pref.setInt('autoCallingIndexValue', index + 1);
      _pref.setInt('autoCallingSubIndexValue', subIndex + 1);
      if (Singleton.instance.startCalling ?? false) {
        print('tdjdjkdjd');
        yield StartCallingState();
      }
    }

    if (event is TapBuildRouteEvent) {
      yield CaseListViewLoadingState();

      page = 1;
      hasNextPage = true;
      // Now set Build Route case is a load more event
      isPriorityLoadMore = false;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> buildRouteListData =
            await APIRepository.apiRequest(
                APIRequestType.GET,
                HttpUrl.buildRouteCaseList +
                    "lat=${event.paramValues.lat}&" +
                    "lng=${event.paramValues.long}&" +
                    "maxDistMeters=${event.paramValues.maxDistMeters}&" +
                    'page=${Constants.pageNo}&' +
                    'limit=${Constants.limit}');

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

    if (event is BuildRouteLoadMoreEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> buildRouteListData =
            await APIRepository.apiRequest(
                APIRequestType.GET,
                HttpUrl.buildRouteCaseList +
                    "lat=${event.paramValues.lat}&" +
                    "lng=${event.paramValues.long}&" +
                    "maxDistMeters=${event.paramValues.maxDistMeters}&" +
                    'page=$page&' +
                    'limit=${Constants.limit}');

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
      yield BuildRouteLoadMoreState(successResponse: resultList);
    }

    if (event is MapViewEvent) {
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
        String? starVal;
        String? recentVal;
        var data = event.returnValue as SearchingDataModel;
        if (data.isStarCases!) {
          starVal = "starredOnly=${data.isStarCases}&";
        }
        if (data.isMyRecentActivity!) {
          recentVal = "recentActivity=${data.isMyRecentActivity}&";
        }
        Map<String, dynamic> getSearchResultData;
        if (data.isStarCases! && data.isMyRecentActivity!) {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.GET,
              HttpUrl.searchUrl +
                  "starredOnly=${data.isStarCases}&" +
                  "recentActivity=${data.isMyRecentActivity}&" +
                  "accNo=${data.accountNumber}&" +
                  "cust=${data.customerName}&" +
                  "dpdStr=${data.dpdBucket}&" +
                  "customerId=${data.customerID}&" +
                  "pincode=${data.pincode}&" +
                  "collSubStatus=${data.status}");
        } else if (data.isStarCases!) {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.GET,
              HttpUrl.searchUrl +
                  "starredOnly=${data.isStarCases}&" +
                  "accNo=${data.accountNumber}&" +
                  "cust=${data.customerName}&" +
                  "dpdStr=${data.dpdBucket}&" +
                  "customerId=${data.customerID}&" +
                  "pincode=${data.pincode}&" +
                  "collSubStatus=${data.status}");
        } else if (data.isMyRecentActivity!) {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.GET,
              HttpUrl.searchUrl +
                  "recentActivity=${data.isMyRecentActivity}&" +
                  "accNo=${data.accountNumber}&" +
                  "cust=${data.customerName}&" +
                  "dpdStr=${data.dpdBucket}&" +
                  "customerId=${data.customerID}&" +
                  "pincode=${data.pincode}&" +
                  "collSubStatus=${data.status}");
        } else {
          getSearchResultData = await APIRepository.apiRequest(
              APIRequestType.GET,
              HttpUrl.searchUrl +
                  "accNo=${data.accountNumber}&" +
                  "cust=${data.customerName}&" +
                  "dpdStr=${data.dpdBucket}&" +
                  "customerId=${data.customerID}&" +
                  "pincode=${data.pincode}&" +
                  "collSubStatus=${data.status}");
        }

        // Map<String, dynamic> getSearchResultData =
        //     await APIRepository.apiRequest(
        //         APIRequestType.GET,
        //         HttpUrl.searchUrl +
        //             "starredOnly=${data.isStarCases}&" +
        //             "recentActivity=${data.isMyRecentActivity}&" +
        //             "accNo=${data.accountNumber}&" +
        //             "cust=${data.customerName}&" +
        //             "dpdStr=${data.dpdBucket}&" +
        //             "customerId=${data.customerID}&" +
        //             "pincode=${data.pincode}&" +
        //             "collSubStatus=${data.status}");

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

    if (event is ShowAutoCallingEvent) {
      isAutoCalling = true;
      isShowSearchFloatingButton = false;
    }
  }
}
