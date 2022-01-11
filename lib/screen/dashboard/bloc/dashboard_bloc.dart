import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_all_models/dashboard_all_models.dart';
import 'package:origa/models/dashboard_event_count_model/dashboard_event_count_model.dart';
import 'package:origa/models/dashboard_event_count_model/result.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/models/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
// import 'package:origa/models/dashboard_models/dashboard_all_model.dart';
import 'package:origa/models/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  List<DashboardListModel> dashboardList = [];
  // List<CaseListModel> caseList = [];
  String? userType;
  String? selectedFilter = 'TODAY';
  bool selectedFilterDataLoading = false;
  DashboardAllModels priortyFollowUpData = DashboardAllModels();
  DashboardAllModels brokenPTPData = DashboardAllModels();
  DashboardAllModels untouchedCasesData = DashboardAllModels();
  DashboardAllModels myVisitsData = DashboardAllModels();
  DashboardAllModels myReceiptsData = DashboardAllModels();
  // DashboardBrokenModel brokenPTPData = DashboardBrokenModel();
  // DashboardUntouchedCasesModel untouchedCasesData =
  //     DashboardUntouchedCasesModel();
  // DashboardMyvisitModel myVisitsData = DashboardMyvisitModel();
  // DashboardMyReceiptsModel myReceiptsData = DashboardMyReceiptsModel();
  MyDeposistModel myDeposistsData = MyDeposistModel();
  YardingData yardingAndSelfReleaseData = YardingData();

  List<String> filterOption = [
    'TODAY',
    'WEEKLY',
    'MONTHLY',
  ];

  // Show the Options
  int customerMetCountValue = 0;
  int customerNotMetCountValue = 0;
  int customerInvalidCountValue = 0;

  int? mtdCaseCompleted = 0;
  int? mtdCaseTotal = 0;
  int? mtdAmountCompleted = 0;
  int? mtdAmountTotal = 0;

  String? todayDate;
  // this is search result cases
  List<Result> searchResultList = [];
  bool isShowSearchResult = false;

  // it's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';

  DashboardEventCountModel dashboardEventCountValue =
      DashboardEventCountModel();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardInitialEvent) {
      yield DashboardLoadingState();

      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString(Constants.userType);
      Singleton.instance.buildContext = event.context;

      var currentDateTime = DateTime.now();
      String currentDate = DateFormat.yMMMEd().format(currentDateTime);
      todayDate = currentDate;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        noInternetAndServerErrorMsg =
            Languages.of(event.context!)!.noInternetConnection;
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic>? dashboardData;
        if (userType == Constants.fieldagent) {
          dashboardData = await APIRepository.apiRequest(
              APIRequestType.GET, HttpUrl.dashboardUrl + "userType=$userType");
        } else if (userType == Constants.telecaller) {
          dashboardData = await APIRepository.apiRequest(APIRequestType.GET,
              HttpUrl.telDashboardUrl + "userType=$userType");
        }

        if (dashboardData!['success']) {
          var jsonData = dashboardData['data']['result'];

          mtdCaseCompleted = jsonData['mtdCases']['completed'];
          mtdCaseTotal = jsonData['mtdCases']['total'];
          mtdAmountCompleted = jsonData['mtdAmount']['completed'];
          mtdAmountTotal = jsonData['mtdAmount']['total'];
          // print(DashboardData['data']);

          dashboardList.addAll([
            DashboardListModel(
              title: Languages.of(event.context!)!.priorityFollowUp,
              image: ImageResource.vectorArrow,
              count: jsonData['priorityFollowUp']['count'].toString(),
              amountRs: jsonData['priorityFollowUp']['totalAmt'].toString(),
            ),
            DashboardListModel(
              title: Languages.of(event.context!)!.untouchedCases,
              image: ImageResource.vectorArrow,
              count: jsonData['untouched']['count'].toString(),
              amountRs: jsonData['untouched']['totalAmt'].toString(),
            ),
            DashboardListModel(
              title: Languages.of(event.context!)!.brokenPTP,
              image: ImageResource.vectorArrow,
              count: jsonData['brokenPtp']['count'].toString(),
              amountRs: jsonData['brokenPtp']['totalAmt'].toString(),
            ),
            DashboardListModel(
              title: Languages.of(event.context!)!.myReceipts,
              image: ImageResource.vectorArrow,
              count: jsonData['receipts']['count'].toString(),
              amountRs: jsonData['receipts']['totalAmt'].toString(),
            ),
            DashboardListModel(
              title: userType == Constants.fieldagent
                  ? Languages.of(event.context!)!.myVisits
                  : Languages.of(event.context!)!.myCalls,
              image: ImageResource.vectorArrow,
              count: jsonData['visits']['count'].toString(),
              amountRs: jsonData['visits']['totalAmt'].toString(),
            ),
            DashboardListModel(
                title: Languages.of(event.context!)!.myDeposists,
                image: '',
                count: '',
                amountRs: ''),
            DashboardListModel(
                title: Languages.of(event.context!)!.yardingSelfRelease,
                image: '',
                count: '',
                amountRs: ''),
          ]);
        } else if (dashboardData['statusCode'] == 401 ||
            dashboardData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          noInternetAndServerErrorMsg = dashboardData['data'];
        }
        Map<String, dynamic> getDashboardEventCountValue =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardEventCountUrl);

        if (getDashboardEventCountValue['success']) {
          Map<String, dynamic> jsonData = getDashboardEventCountValue['data'];
          dashboardEventCountValue =
              DashboardEventCountModel.fromJson(jsonData);
        }

        dashboardEventCountValue.result?.forEach((element) {
          if (element.eventType!.contains('PTP') ||
              element.eventType!.contains('DENIAL') ||
              element.eventType!.contains('DISPUTE') ||
              element.eventType!.contains('REMINDER') ||
              element.eventType!.contains('RECEIPT') ||
              element.eventType!.contains('OTS')) {
            customerMetCountValue++;
          }
          if (element.eventType!.contains('Left Message') ||
              element.eventType!.contains('Door Locked') ||
              element.eventType!.contains('Entry Restricted')) {
            customerNotMetCountValue++;
          }
          if (element.eventType!.contains('Wrong Address') ||
              element.eventType!.contains('Shifted') ||
              element.eventType!.contains('Address Not Found')) {
            customerInvalidCountValue++;
          }
        });

        // print(
        //     'Dashboard Evnet Vaaldjkd d = ======== > ${jsonEncode(dashboardEventCountValue.result)}');
      }
// caseList.clear();
      // caseList.addAll([
      //   CaseListModel(
      //     newlyAdded: true,
      //     customerName: 'Debashish Patnaik',
      //     amount: '₹ 3,97,553.67',
      //     address: '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
      //     date: 'Today, Thu 18 Oct, 2021',
      //     loanID: '618e382004d8d040ac18841b',
      //   ),
      //   CaseListModel(
      //     newlyAdded: true,
      //     customerName: 'New User',
      //     amount: '₹ 5,54,433.67',
      //     address: '2/345, 6th Main Road, Bangalore - 534544',
      //     date: 'Thu, Thu 18 Oct, 2021',
      //     loanID: '618e382004d8d040ac18841b',
      //   ),
      //   CaseListModel(
      //     newlyAdded: true,
      //     customerName: 'Debashish Patnaik',
      //     amount: '₹ 8,97,553.67',
      //     address: '2/345, 1th Main Road Guindy, Chenai - 875032',
      //     date: 'Sat, Thu 18 Oct, 2021',
      //     loanID: '618e382004d8d040ac18841b',
      //   ),
      // ]);

      yield DashboardLoadedState();
    }

    if (event is PriorityFollowEvent) {
      // Here we clear and flase the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getPriorityFollowUpData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardPriorityFollowUpUrl);
        priortyFollowUpData =
            DashboardAllModels.fromJson(getPriorityFollowUpData['data']);
        // print(getPriorityFollowUpData['data']);
        if (getPriorityFollowUpData[Constants.success]) {
          yield PriorityFollowState();
        }
      }
    }

    if (event is UntouchedCasesEvent) {
      // Here we clear and flase the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getUntouchedCasesData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardUntouchedCasesUrl);
        untouchedCasesData =
            DashboardAllModels.fromJson(getUntouchedCasesData['data']);
        // print(getUntouchedCasesData['data']);
        if (getUntouchedCasesData[Constants.success]) {
          yield UntouchedCasesState();
        }
      }
    }

    if (event is BrokenPTPEvent) {
      // Here we clear and flase the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getBrokenPTPData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardBrokenPTPUrl);
        brokenPTPData = DashboardAllModels.fromJson(getBrokenPTPData['data']);
        if (getBrokenPTPData[Constants.success]) {
          yield BrokenPTPState();
        }
      }
      // yield BrokenPTPState();
    }

    if (event is MyReceiptsEvent) {
      // Here we clear and false the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getMyReceiptsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyReceiptsUrl + 'timePeriod=' + selectedFilter!);
        myReceiptsData = DashboardAllModels.fromJson(getMyReceiptsData['data']);
        // print(getMyReceiptsData['data']);
        if (getMyReceiptsData[Constants.success]) {
          yield MyReceiptsState();
        }
      }
      // yield MyReceiptsState();
    }

    if (event is ReceiptsApiEvent) {
      // Here we clear and false the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      yield SelectedTimeperiodDataLoadingState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getMyReceiptsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyReceiptsUrl + 'timePeriod=${event.timePeiod}');
        if (getMyReceiptsData[Constants.success]) {
          yield ReturnReceiptsApiState(returnData: getMyReceiptsData['data']);
        }
      }
      yield SelectedTimeperiodDataLoadedState();
    }

    if (event is MyVisitsEvent) {
      // Here we clear and false the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getMyVisitsData;
        if (userType == Constants.fieldagent) {
          getMyVisitsData = await APIRepository.apiRequest(APIRequestType.GET,
              HttpUrl.dashboardMyVisitsUrl + 'timePeriod=' + selectedFilter!);
        } else {
          getMyVisitsData = await APIRepository.apiRequest(APIRequestType.GET,
              HttpUrl.dashboardMyCallsUrl + 'timePeriod=' + selectedFilter!);
        }

        myVisitsData = DashboardAllModels.fromJson(getMyVisitsData['data']);
        // print(getMyVisitsData['data']);
        if (getMyVisitsData[Constants.success]) {
          yield MyVisitsState();
        }
      }
      // yield MyVisitsState();
    }

    if (event is MyVisitApiEvent) {
      // Here we clear and flase the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      yield SelectedTimeperiodDataLoadingState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        // yield SelectedTimeperiodDataLoadedState();
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getMyVisitsData;
        if (userType == Constants.fieldagent) {
          getMyVisitsData = await APIRepository.apiRequest(APIRequestType.GET,
              HttpUrl.dashboardMyVisitsUrl + "timePeriod=${event.timePeiod}");
        } else {
          getMyVisitsData = await APIRepository.apiRequest(APIRequestType.GET,
              HttpUrl.dashboardMyCallsUrl + "timePeriod=${event.timePeiod}");
        }
        // Map<String, dynamic> getMyVisitsData = await APIRepository.apiRequest(
        //     APIRequestType.GET,
        //     HttpUrl.dashboardMyVisitsUrl + "timePeriod=${event.timePeiod}");
        if (getMyVisitsData[Constants.success]) {
          yield ReturnVisitsApiState(returnData: getMyVisitsData['data']);
        }
      }
      yield SelectedTimeperiodDataLoadedState();
    }

    if (event is MyDeposistsEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getMyDepositsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyDeposistsUrl + 'timePeriod=' + selectedFilter!);
        myDeposistsData = MyDeposistModel.fromJson(getMyDepositsData['data']);
        // print(getMyDepositsData['data']);
        if (getMyDepositsData[Constants.success]) {
          // yield SelectedTimeperiodDataLoadedState();

          yield MyDeposistsState();
        }
      }
      // yield MyDeposistsState();
    }

    if (event is DeposistsApiEvent) {
      yield SelectedTimeperiodDataLoadingState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getMyDepositsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyDeposistsUrl + "timePeriod=${event.timePeiod}");
        myDeposistsData = MyDeposistModel.fromJson(getMyDepositsData['data']);
        if (getMyDepositsData[Constants.success]) {}
      }
      yield SelectedTimeperiodDataLoadedState();
    }

    if (event is YardingAndSelfReleaseEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getYardingAndSelfReleaseData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardYardingAndSelfReleaseUrl);
        yardingAndSelfReleaseData =
            YardingData.fromJson(getYardingAndSelfReleaseData['data']);
        if (getYardingAndSelfReleaseData[Constants.success]) {
          yield YardingAndSelfReleaseState();
        }
      }

      // yield YardingAndSelfReleaseState();
    }

    if (event is PostBankDepositDataEvent) {
      yield DisableMDBankSubmitBtnState();
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.bankDeposit + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult['success']) {
        yield PostDataApiSuccessState();
      }
      yield EnableMDBankSubmitBtnState();
    }

    if (event is PostCompanyDepositDataEvent) {
      yield DisableMDCompanyBranchSubmitBtnState();
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST,
          HttpUrl.companyBranchDeposit + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableMDCompanyBranchSubmitBtnState();
    }

    if (event is PostYardingDataEvent) {
      yield DisableRSYardingSubmitBtnState();
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.yarding + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableRSYardingSubmitBtnState();
    }

    if (event is PostSelfreleaseDataEvent) {
      yield DisableRSSelfReleaseSubmitBtnState();
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.selfRelease + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableRSSelfReleaseSubmitBtnState();
    }

    if (event is NavigateCaseDetailEvent) {
      yield NavigateCaseDetailState(paramValues: event.paramValues);
    }

    if (event is NavigateSearchEvent) {
      yield NavigateSearchState();
    }

    if (event is SetTimeperiodValueEvent) {
      yield SetTimeperiodValueState();
    }

    if (event is HelpEvent) {
      yield HelpState();
    }

    if (event is SearchReturnDataEvent) {
      yield SelectedTimeperiodDataLoadingState();

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
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

        //         Map<String, dynamic> getSearchResultData =
        // await APIRepository.apiRequest(
        //     APIRequestType.GET,
        //     HttpUrl.priorityCaseList +
        //         'pageNo=${Constants.pageNo}' +
        //         '&limit=${Constants.limit}');
        // if get search result is show true
        searchResultList.clear();
        isShowSearchResult = true;

        for (var element in getSearchResultData['data']['result']) {
          searchResultList
              .add(Result.fromJson(jsonDecode(jsonEncode(element))));
        }

        yield SelectedTimeperiodDataLoadedState();

        yield GetSearchDataState();
      }
    }
  }
}
