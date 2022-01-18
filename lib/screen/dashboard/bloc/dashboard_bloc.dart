import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_all_models/dashboard_all_models.dart';
import 'package:origa/models/dashboard_card_count_model.dart';
import 'package:origa/models/dashboard_event_count_model/dashboard_event_count_model.dart';
import 'package:origa/models/dashboard_event_count_model/result.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/models/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:origa/models/dashboard_myvisit_model/dashboard_myvisit_model.dart';
// import 'package:origa/models/dashboard_models/dashboard_all_model.dart';
import 'package:origa/models/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:origa/models/my_receipts_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/receipts_weekly_model/case.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardReceiptWeekly {
  late String caseId;
  late String appStatus;
  late ReceiptWeeklyCase caseValue;
  DashboardReceiptWeekly(this.caseId, this.appStatus, this.caseValue);
}

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
  MyVisitsCaseModel myVisitsData = MyVisitsCaseModel();
  MyReceiptsCaseModel myReceiptsData = MyReceiptsCaseModel();
  // DashboardBrokenModel brokenPTPData = DashboardBrokenModel();
  // DashboardUntouchedCasesModel untouchedCasesData =
  //     DashboardUntouchedCasesModel();
  // DashboardMyvisitModel myVisitsData = DashboardMyvisitModel();
  // DashboardMyReceiptsModel myReceiptsData = DashboardMyReceiptsModel();
  MyDeposistModel myDeposistsData = MyDeposistModel();
  // Deposists selected case index
  // List listOfIndex = [];

  YardingData yardingAndSelfReleaseData = YardingData();
  DashboardCardCount dashboardCardCounts = DashboardCardCount();

  List<String> filterOption = [
    'TODAY',
    'WEEKLY',
    'MONTHLY',
  ];

  // // Show the Options
  // String? customerMetCountValue;
  // String? customerNotMetCountValue;
  // String? customerInvalidCountValue;

  dynamic mtdCaseCompleted = 0;
  dynamic mtdCaseTotal = 0;
  dynamic mtdAmountCompleted = 0;
  dynamic mtdAmountTotal = 0;

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
          // var jsonData = dashboardData['data']['result'];

          dashboardCardCounts =
              DashboardCardCount.fromJson(dashboardData['data']);

          print(dashboardCardCounts.result?.notMet?.count);

          mtdCaseCompleted = dashboardCardCounts.result?.mtdCases!.completed;
          mtdCaseTotal = dashboardCardCounts.result?.mtdCases!.total;
          mtdAmountCompleted = dashboardCardCounts.result?.mtdAmount!.completed;
          mtdAmountTotal = dashboardCardCounts.result?.mtdAmount!.total;

          dashboardList.addAll([
            DashboardListModel(
              title: Languages.of(event.context!)!.priorityFollowUp,
              image: ImageResource.vectorArrow,
              count: dashboardCardCounts.result?.priorityFollowUp!.count
                  .toString(),
              amountRs: dashboardCardCounts.result?.priorityFollowUp!.totalAmt
                  .toString(),
            ),
            DashboardListModel(
              title: Languages.of(event.context!)!.untouchedCases,
              image: ImageResource.vectorArrow,
              count: dashboardCardCounts.result?.untouched!.count.toString(),
              amountRs:
                  dashboardCardCounts.result?.untouched!.totalAmt.toString(),
            ),
            DashboardListModel(
              title: Languages.of(event.context!)!.brokenPTP,
              image: ImageResource.vectorArrow,
              count: dashboardCardCounts.result?.brokenPtp!.count.toString(),
              amountRs:
                  dashboardCardCounts.result?.brokenPtp!.totalAmt.toString(),
            ),
            DashboardListModel(
              title: Languages.of(event.context!)!.myReceipts,
              image: ImageResource.vectorArrow,
              count: dashboardCardCounts.result?.receipts!.count.toString(),
              amountRs:
                  dashboardCardCounts.result?.receipts!.totalAmt.toString(),
            ),
            DashboardListModel(
              title: userType == Constants.fieldagent
                  ? Languages.of(event.context!)!.myVisits
                  : Languages.of(event.context!)!.myCalls,
              image: ImageResource.vectorArrow,
              count:
                  dashboardCardCounts.result?.visits?.count.toString() ?? '0',
              amountRs:
                  dashboardCardCounts.result?.visits?.totalAmt.toString() ??
                      '0',
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
        // Map<String, dynamic> getDashboardEventCountValue =
        //     await APIRepository.apiRequest(
        //         APIRequestType.GET, HttpUrl.dashboardEventCountUrl);

        // if (getDashboardEventCountValue['success']) {
        //   print("Today Activities ==> ${getDashboardEventCountValue['data']}");
        //   Map<String, dynamic> jsonData = getDashboardEventCountValue['data'];
        //   dashboardEventCountValue =
        //       DashboardEventCountModel.fromJson(jsonData);
        // }

        // dashboardEventCountValue.result?.forEach((element) {
        // for (DashboardEventCountResult element
        //     in dashboardEventCountValue.result!) {
        //   if (element.eventType! == Constants.ptp ||
        //       element.eventType! == Constants.denial ||
        //       element.eventType! == Constants.dispute ||
        //       element.eventType! == Constants.remainder.toUpperCase() ||
        //       element.eventType! == Constants.receipt ||
        //       // element.eventType! == "REPO" ||
        //       // element.eventType! == "Feedback" ||
        //       element.eventType! == Constants.ots) {
        //     // print("customerMetCountValue=========");
        //     // print(element.eventType!);
        //     customerMetCountValue.add(element.eventType!);
        //   }
        // }

        // for (DashboardEventCountResult element
        //     in dashboardEventCountValue.result!) {
        //   if (element.eventType! == Constants.leftMessage ||
        //       element.eventType! == Constants.doorLocked ||
        //       element.eventType! == Constants.entryRestricted ||
        //       element.eventType! == Constants.switchOff ||
        //       element.eventType! == Constants.rnr ||
        //       element.eventType! == Constants.outOfNetwork ||
        //       element.eventType! == Constants.disconnecting ||
        //       element.eventType! == Constants.lineBusy) {
        //     customerNotMetCountValue.add(element.eventType!);
        //   }
        // }

        // for (DashboardEventCountResult element
        //     in dashboardEventCountValue.result!) {
        //   if (element.eventType! == Constants.wrongAddress ||
        //       element.eventType! == Constants.shifted ||
        //       element.eventType! == Constants.addressNotFound ||
        //       element.eventType! == Constants.doesNotExist ||
        //       element.eventType! == Constants.incorrectNumber ||
        //       element.eventType! == Constants.notOpeartional ||
        //       element.eventType! == Constants.numberNotWorking) {
        //     customerInvalidCountValue.add(element.eventType!);
        //   }
        // }

        // Map<String, dynamic> getDashboardEventCountValue1 =
        //     await APIRepository.apiRequest(APIRequestType.GET,
        //         'https://uat-collect.origa.ai/app_otc/v1/agent/case-details/receipts?timePeriod=WEEKLY');

        // ReceiptsWeeklyModel tempModel = ReceiptsWeeklyModel();
        // List<String> tempNewCaseId = [];
        // List<String> tempApporvedCaseId = [];
        // List<String> tempPendingCaseId = [];
        // if (getDashboardEventCountValue1['success']) {
        //   Map<String, dynamic> jsonData = getDashboardEventCountValue1['data'];
        //   tempModel = ReceiptsWeeklyModel.fromJson(jsonData);
        // }

        // tempModel.result?.receiptEvent?.forEach((element) {
        //   if (element.eventAttr!.appStatus!.contains('new')) {
        //     tempNewCaseId.add(element.caseId.toString());
        //   }
        //   if (element.eventAttr!.appStatus!.contains('approved')) {
        //     tempApporvedCaseId.add(element.caseId.toString());
        //   }
        //   if (element.eventAttr!.appStatus!.contains('pending')) {
        //     tempPendingCaseId.add(element.caseId.toString());
        //   }
        // });

        // List<DashboardReceiptWeekly> tempReceiptWeekly = [];
        // tempNewCaseId.forEach((ele) {
        //   tempModel.result?.cases?.forEach((element) {
        //     if (element.caseId!.contains(ele)) {
        //       tempReceiptWeekly
        //           .add(DashboardReceiptWeekly(ele, 'new', element));
        //     }
        //   });
        // });
        // tempApporvedCaseId.forEach((ele) {
        //   tempModel.result?.cases?.forEach((element) {
        //     if (element.caseId!.contains(ele)) {
        //       tempReceiptWeekly
        //           .add(DashboardReceiptWeekly(ele, 'apporved', element));
        //     }
        //   });
        // });
        // tempPendingCaseId.forEach((ele) {
        //   tempModel.result?.cases?.forEach((element) {
        //     if (element.caseId!.contains(ele)) {
        //       tempReceiptWeekly
        //           .add(DashboardReceiptWeekly(ele, 'pending', element));
        //     }
        //   });
        // });

        // tempReceiptWeekly.forEach((element) {
        //   print('Element Value is => ${element.caseId}');
        // });
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
        myReceiptsData =
            MyReceiptsCaseModel.fromJson(getMyReceiptsData['data']);
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

        myVisitsData = MyVisitsCaseModel.fromJson(getMyVisitsData['data']);
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
      // Map<String, dynamic> postResult = await APIRepository.apiRequest(
      //     APIRequestType.POST, HttpUrl.bankDeposit + "userType=$userType",
      //     requestBodydata: jsonEncode(event.postData));
      final Map<String, dynamic> postdata =
          jsonDecode(jsonEncode(event.postData!.toJson()))
              as Map<String, dynamic>;
      List<dynamic> value = [];
      for (var element in event.fileData!) {
        value.add(await MultipartFile.fromFile(element.path.toString()));
      }
      postdata.addAll({
        'files': value,
      });
      print('Post Data => ${postdata}');
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.UPLOAD,
        HttpUrl.bankDeposit + "userType=$userType",
        formDatas: FormData.fromMap(postdata),
      );

      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableMDBankSubmitBtnState();
    }

    if (event is PostCompanyDepositDataEvent) {
      yield DisableMDCompanyBranchSubmitBtnState();
      final Map<String, dynamic> postdata =
          jsonDecode(jsonEncode(event.postData!.toJson()))
              as Map<String, dynamic>;
      List<dynamic> value = [];
      for (var element in event.fileData!) {
        value.add(await MultipartFile.fromFile(element.path.toString()));
      }
      postdata.addAll({
        'files': value,
      });
      print('Post Data => ${postdata}');
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.UPLOAD,
        HttpUrl.companyBranchDeposit + "userType=$userType",
        formDatas: FormData.fromMap(postdata),
      );

      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableMDCompanyBranchSubmitBtnState();
    }

    if (event is PostYardingDataEvent) {
      yield DisableRSYardingSubmitBtnState();
      final Map<String, dynamic> postdata =
          jsonDecode(jsonEncode(event.postData!.toJson()))
              as Map<String, dynamic>;
      List<dynamic> value = [];
      for (var element in event.fileData!) {
        value.add(await MultipartFile.fromFile(element.path.toString()));
      }
      postdata.addAll({
        'files': value,
      });
      print('Post Data => ${postdata}');
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.UPLOAD,
        HttpUrl.yarding + "userType=$userType",
        formDatas: FormData.fromMap(postdata),
      );

      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
      yield EnableRSYardingSubmitBtnState();
    }

    if (event is PostSelfreleaseDataEvent) {
      yield DisableRSSelfReleaseSubmitBtnState();
      final Map<String, dynamic> postdata =
          jsonDecode(jsonEncode(event.postData!.toJson()))
              as Map<String, dynamic>;
      List<dynamic> value = [];
      for (var element in event.fileData!) {
        value.add(await MultipartFile.fromFile(element.path.toString()));
      }
      postdata.addAll({
        'files': value,
      });
      print('Post Data => ${postdata}');
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.UPLOAD,
        HttpUrl.selfRelease + "userType=$userType",
        formDatas: FormData.fromMap(postdata),
      );

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
