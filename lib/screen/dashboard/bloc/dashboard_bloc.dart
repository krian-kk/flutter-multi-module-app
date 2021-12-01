import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/dashboard_all_models/dashboard_all_models.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/models/dashboard_my_receipts_model/dashboard_my_receipts_model.dart';
import 'package:origa/models/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:origa/models/dashboard_myvisit_model/dashboard_myvisit_model.dart';
import 'package:origa/models/dashboard_priority_model/dashboard_priority_model.dart';
import 'package:origa/models/dashboard_untouched_cases_model/dashboard_untouched_cases_model.dart';
import 'package:origa/models/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:origa/models/search_model/search_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/image_resource.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  List<DashboardListModel> dashboardList = [];
  List<CaseListModel> caseList = [];
  String? selectedFilter = 'TODAY';
  DashboardPriorityModel priortyFollowUpData = DashboardPriorityModel();
  DashboardAllModels brokenPTPData = DashboardAllModels();
  DashboardUntouchedCasesModel untouchedCasesData =
      DashboardUntouchedCasesModel();
  DashboardMyvisitModel myVisitsData = DashboardMyvisitModel();
  DashboardMyReceiptsModel myReceiptsData = DashboardMyReceiptsModel();
  DashboardMydeposistsModel myDeposistsData = DashboardMydeposistsModel();
  DashboardYardingandSelfReleaseModel yardingAndSelfReleaseData =
      DashboardYardingandSelfReleaseModel();

  List<String> filterOption = [
    'TODAY',
    'WEEKLY',
    'MONTHLY',
  ];

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardInitialEvent) {
      yield DashboardLoadingState();

// dashboardList.clear();
      dashboardList.addAll([
        DashboardListModel(
          title: 'PRIORITY FOLLOW UP',
          image: ImageResource.vectorArrow,
          count: 'Count',
          countNum: '200',
          amount: 'Amount',
          amountRs: '₹ 3,97,553.67',
          // onTap: (){
          //   print('object');
          // },
        ),
        DashboardListModel(
            title: 'UNTOUCHED CASES',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'BROKEN PTP',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'MY RECEIPTS',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'MY VISITS',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'MY DEPOSISTS',
            image: '',
            count: '',
            countNum: '',
            amount: '',
            amountRs: ''),
        DashboardListModel(
            title: 'YARDING & SELF- RELEASE',
            image: '',
            count: '',
            countNum: '',
            amount: '',
            amountRs: ''),
      ]);
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
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getProfileFollowUpData =
            await APIRepository.apiRequest(APIRequestType.GET,
                HttpUrl.dashboardPriorityProirityFollowUpUrl + '411036');
        priortyFollowUpData =
            DashboardPriorityModel.fromJson(getProfileFollowUpData['data']);
      }

      yield PriorityFollowState();
    }

    if (event is UntouchedCasesEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getUntouchedCasesData =
            await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.dashboardUntouchedCasesUrl + '');
        untouchedCasesData = DashboardUntouchedCasesModel.fromJson(
            getUntouchedCasesData['data']);
      }
      yield UntouchedCasesState();
    }

    if (event is BrokenPTPEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getBrokenPTPData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardBrokenPTPUrl + '');
        brokenPTPData = DashboardAllModels.fromJson(getBrokenPTPData['data']);
      }
      yield BrokenPTPState();
    }

    if (event is MyReceiptsEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        // Map<String, dynamic> getMyReceiptsData =
        //     await APIRepository.getDashboardMyReceiptsData('WEEKLY');
        Map<String, dynamic> getMyReceiptsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardMyReceiptsUrl + 'WEEKLY');
        myReceiptsData =
            DashboardMyReceiptsModel.fromJson(getMyReceiptsData['data']);
      }
      yield MyReceiptsState();
    }

    if (event is MyVisitsEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        Map<String, dynamic> getMyVisitsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardMyVisitsUrl + '');
        myVisitsData = DashboardMyvisitModel.fromJson(getMyVisitsData['data']);
      }
      yield MyVisitsState();
    }

    if (event is MyDeposistsEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        // Map<String, dynamic> getMyDepositsData =
        //     await APIRepository.getDashboardMyDeposistsData('WEEKLY');
        Map<String, dynamic> getMyDepositsData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.dashboardMyDeposistsUrl + 'WEEKLY');
        myDeposistsData =
            DashboardMydeposistsModel.fromJson(getMyDepositsData['data']);
      }
      yield MyDeposistsState();
    }

    if (event is YardingAndSelfReleaseEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
      } else {
        // Map<String, dynamic> getYardingAndSelfReleaseData =
        //     await APIRepository.getDashboardYardingAndSelfReleaseData(
        //         '5f80375a86527c46deba2e60');
        Map<String, dynamic> getYardingAndSelfReleaseData =
            await APIRepository.apiRequest(
                APIRequestType.GET,
                HttpUrl.dashboardYardingAndSelfReleaseUrl +
                    '5f80375a86527c46deba2e60');
        yardingAndSelfReleaseData =
            DashboardYardingandSelfReleaseModel.fromJson(
                getYardingAndSelfReleaseData['data']);
      }
      yield YardingAndSelfReleaseState();
    }

    if (event is NavigateCaseDetailEvent) {
      yield NavigateCaseDetailState();
    }

    if (event is NavigateSearchEvent) {
      yield NavigateSearchState();
    }
    if (event is ClickDashboardSearchButtonEvent) {
      yield SearchDashboardScreenLoadedState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
        yield SearchDashboardFailedState('Please Connect Internet!');
      } else {
        // Map<String, dynamic> getSearchData =
        //     await APIRepository.getSearchData(event.searchField);
        Map<String, dynamic> getSearchData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.searchUrl + 'MOR000800314934');
        var searchData = SearchModel.fromJson(getSearchData['data']);
        yield SearchDashboardScreenSuccessState(searchData);
      }
    }
    if (event is HelpEvent) {
      yield HelpState();
    }
  }
}
