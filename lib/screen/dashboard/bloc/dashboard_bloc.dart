import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_all_models/dashboard_all_models.dart';
import 'package:origa/models/dashboard_model.dart';
// import 'package:origa/models/dashboard_models/dashboard_all_model.dart';
import 'package:origa/models/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:origa/models/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  List<DashboardListModel> dashboardList = [];
  List<CaseListModel> caseList = [];
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
  DashboardMydeposistsModel myDeposistsData = DashboardMydeposistsModel();
  DashboardYardingandSelfReleaseModel yardingAndSelfReleaseData =
      DashboardYardingandSelfReleaseModel();

  List<String> filterOption = [
    'TODAY',
    'WEEKLY',
    'MONTHLY',
  ];

  String? mtdCaseCompleted;
  String? mtdCaseTotal;
  String? mtdAmountCompleted;
  String? mtdAmountTotal;

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardInitialEvent) {
      yield DashboardLoadingState();

      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString('userType');

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      }

      Map<String, dynamic> DashboardData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardUrl + "userType=$userType");

        if (DashboardData['success'] == true) {
         var jsonData = DashboardData['data']['result'];

         mtdCaseCompleted = jsonData['mtdCases']['completed'].toString();
         mtdCaseTotal = jsonData['mtdCases']['total'].toString();
         mtdAmountCompleted = jsonData['mtdAmount']['completed'].toString();
         mtdAmountTotal = jsonData['mtdAmount']['total'].toString();
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
            title: userType == Constants.fieldagent ? Languages.of(event.context!)!.myVisits : Languages.of(event.context!)!.myCalls,
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
    }
// caseList.clear();
      caseList.addAll([
        CaseListModel(
          newlyAdded: true,
          customerName: 'Debashish Patnaik',
          amount: '₹ 3,97,553.67',
          address: '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
          date: 'Today, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
        ),
        CaseListModel(
          newlyAdded: true,
          customerName: 'New User',
          amount: '₹ 5,54,433.67',
          address: '2/345, 6th Main Road, Bangalore - 534544',
          date: 'Thu, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
        ),
        CaseListModel(
          newlyAdded: true,
          customerName: 'Debashish Patnaik',
          amount: '₹ 8,97,553.67',
          address: '2/345, 1th Main Road Guindy, Chenai - 875032',
          date: 'Sat, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
        ),
      ]);

      yield DashboardLoadedState();
    }

    if (event is PriorityFollowEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      } else {
        Map<String, dynamic> getPriorityFollowUpData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardPriorityFollowUpUrl);
        priortyFollowUpData =
            DashboardAllModels.fromJson(getPriorityFollowUpData['data']);
        print(getPriorityFollowUpData['data']);
      }

      yield PriorityFollowState();
    }

    if (event is UntouchedCasesEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getUntouchedCasesData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardUntouchedCasesUrl);
        untouchedCasesData =
            DashboardAllModels.fromJson(getUntouchedCasesData['data']);
        print(getUntouchedCasesData['data']);
      }
      yield UntouchedCasesState();
    }

    if (event is BrokenPTPEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getBrokenPTPData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardBrokenPTPUrl);
        brokenPTPData = DashboardAllModels.fromJson(getBrokenPTPData['data']);
      }
      yield BrokenPTPState();
    }

    if (event is MyReceiptsEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getMyReceiptsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyReceiptsUrl + 'timePeriod=' + selectedFilter!);
        myReceiptsData = DashboardAllModels.fromJson(getMyReceiptsData['data']);
        print(getMyReceiptsData['data']);
      }
      yield MyReceiptsState();
    }

    if (event is ReceiptsApiEvent) {
      yield SelectedTimeperiodDataLoadingState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
         Map<String, dynamic> getMyReceiptsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardMyReceiptsUrl + 
            'timePeriod=${event.timePeiod}');
            if(getMyReceiptsData['success']) {
             yield ReturnReceiptsApiState(returnData: getMyReceiptsData['data']);
            }
            yield SelectedTimeperiodDataLoadedState();
      }

    }

    if (event is MyVisitsEvent) {
      print(selectedFilter);
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getMyVisitsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyVisitsUrl + 'timePeriod=' + selectedFilter!);
        myVisitsData = DashboardAllModels.fromJson(getMyVisitsData['data']);
        print(getMyVisitsData['data']);
      }
      yield MyVisitsState();
    }

    if (event is MyVisitApiEvent) {
      yield SelectedTimeperiodDataLoadingState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getMyVisitsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardMyVisitsUrl + 
            "timePeriod=${event.timePeiod}");
        if(getMyVisitsData['success']) {
             yield ReturnVisitsApiState(returnData: getMyVisitsData['data']);
            }

            yield SelectedTimeperiodDataLoadedState();
      }
    }

    if (event is MyDeposistsEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getMyDepositsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyDeposistsUrl + 'timePeriod=' + selectedFilter!);
        myDeposistsData =
            DashboardMydeposistsModel.fromJson(getMyDepositsData['data']);
        print(getMyDepositsData['data']);
      }
      yield MyDeposistsState();
    }

    if (event is DeposistsApiEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getMyDepositsData = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.dashboardMyDeposistsUrl + "timePeriod=${event.timePeiod}");
        myDeposistsData =
            DashboardMydeposistsModel.fromJson(getMyDepositsData['data']);
      }
    }

    if (event is YardingAndSelfReleaseEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getYardingAndSelfReleaseData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardYardingAndSelfReleaseUrl);
        yardingAndSelfReleaseData =
            DashboardYardingandSelfReleaseModel.fromJson(
                getYardingAndSelfReleaseData['data']);
      }
      yield YardingAndSelfReleaseState();
    }

    if (event is PostBankDepositDataEvent) {
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.bankDeposit + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is PostCompanyDepositDataEvent) {
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST,
          HttpUrl.companyBranchDeposit + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is PostYardingDataEvent) {
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.yarding + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));
      if (postResult['success']) {
        yield PostDataApiSuccessState();
      }
    }

    if (event is PostSelfreleaseDataEvent) {
      print('userType----------');
      print(userType);
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.selfRelease + "userType=$userType",
          requestBodydata: jsonEncode(event.postData));

      if (postResult['success']) {
        yield PostDataApiSuccessState();
      }
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

        //             Map<String, dynamic> getSearchResultData = await APIRepository.apiRequest(
        //     APIRequestType.GET, HttpUrl.dashboardMyVisitsUrl + 
        //     "timePeriod=WEEKLY");
        // print('getSearchResultData----->');
        // print(getSearchResultData['data']);
        
        // for (var element in getSearchResultData['data']['result']) {
        //   resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
         
        // }
            yield GetSearchDataState(getReturnValues: getSearchResultData['data']);
      }
      yield SelectedTimeperiodDataLoadedState();
    }
  }
}
