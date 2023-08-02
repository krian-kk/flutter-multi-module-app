import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain_models/response_models/dashboard/dashboard_data.dart';
import 'package:domain_models/response_models/dashboard/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:domain_models/response_models/dashboard/dashboard_myvisit_model.dart';
import 'package:domain_models/response_models/dashboard/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:domain_models/response_models/dashboard/my_receipts_model.dart';
import 'package:domain_models/response_models/dashboard/response_priority_follow_up_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:origa/models/dashboard_all_models/result.dart';
import 'package:origa/models/dashboard_event_count_model/dashboard_event_count_model.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:repository/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<DashboardEvent>(_onEvent);
  }

  List<DashboardListModel> dashboardList = <DashboardListModel>[];
  String? userType;
  bool selectedFilterDataLoading = false;
  DashboardEventsCaseResults priorityFollowUpData =
      DashboardEventsCaseResults();
  DashboardEventsCaseResults brokenPTPData = DashboardEventsCaseResults();
  DashboardEventsCaseResults untouchedCasesData = DashboardEventsCaseResults();
  MyVisitResult myVisitsData = MyVisitResult();
  MyReceiptResult myReceiptsData = MyReceiptResult();
  DepositResult myDepositsData = DepositResult();
  List<YardingResult> yardingAndSelfReleaseData = [];

  String? selectedFilter = Constants.today;
  String? selectedFilterIndex = '0';
  List<FilterCasesByTimePeriod> filterOption = <FilterCasesByTimePeriod>[];

  dynamic mtdCaseCompleted = 0;
  dynamic mtdCaseTotal = 0;
  dynamic mtdAmountCompleted = 0;
  dynamic mtdAmountTotal = 0;
  dynamic met = 0;
  dynamic notMet = 0;
  dynamic invalid = 0;

  String? todayDate;

  // This is search result cases
  List<Result> searchResultList = <Result>[];
  bool isShowSearchResult = false;

// Dashboard card onclick loading
  bool isClickToCardLoading = false;

  // It's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';

  DashboardEventCountModel dashboardEventCountValue =
      DashboardEventCountModel();

  DashBoardRepository repository;

  Future<void> _onEvent(
      DashboardEvent event, Emitter<DashboardState> emit) async {
    if (event is DashboardInitialEvent) {
      emit(DashboardLoadingState());
      userType = 'FIELDAGENT';
      // Singleton.instance.buildContext = event.context;

      final DateTime currentDateTime = DateTime.now();
      final String currentDate = DateFormat.yMMMEd().format(currentDateTime);
      todayDate = currentDate;

      filterOption.addAll(<FilterCasesByTimePeriod>[
        FilterCasesByTimePeriod(timePeriodText: 'today', value: '0'),
        FilterCasesByTimePeriod(timePeriodText: 'weekly', value: '1'),
        FilterCasesByTimePeriod(timePeriodText: 'monthly', value: '2'),
      ]);

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        noInternetAndServerErrorMsg = 'noInternetConnection';
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<DashCountResult> dashBoardData =
            await repository.getDashboardData(userType ?? '');
        await dashBoardData.when(
            success: (DashCountResult? dashCountResultData) async {
              mtdCaseCompleted = dashCountResultData?.mtdCases?.completed;
              mtdCaseTotal = dashCountResultData?.mtdCases?.total;
              mtdAmountCompleted = dashCountResultData?.mtdAmount?.completed;
              mtdAmountTotal = dashCountResultData?.mtdAmount?.total;
              met = dashCountResultData?.met?.count.toString();
              notMet = dashCountResultData?.notMet?.count.toString();
              invalid = dashCountResultData?.invalid?.count.toString();
              dashboardList.addAll([
                DashboardListModel(
                  title: 'priorityFollowUp',
                  subTitle: 'customer',
                  image: ImageResource.vectorArrow,
                  count:
                      dashCountResultData?.priorityFollowUp?.count.toString() ??
                          '0',
                  amountRs: dashCountResultData?.priorityFollowUp!.totalAmt
                          .toString() ??
                      '0',
                ),
                DashboardListModel(
                  title: 'untouchedCases',
                  subTitle: 'customer',
                  image: ImageResource.vectorArrow,
                  count:
                      dashCountResultData?.untouched?.count.toString() ?? '0',
                  amountRs:
                      dashCountResultData?.untouched?.totalAmt.toString() ??
                          '0',
                ),
                DashboardListModel(
                  title: 'brokenPTP',
                  subTitle: 'customer',
                  image: ImageResource.vectorArrow,
                  count:
                      dashCountResultData?.brokenPtp?.count.toString() ?? '0',
                  amountRs:
                      dashCountResultData?.brokenPtp?.totalAmt.toString() ??
                          '0',
                ),
                DashboardListModel(
                  title: 'myReceipts',
                  subTitle: 'event',
                  image: ImageResource.vectorArrow,
                  count: dashCountResultData?.receipts!.count.toString() ?? '0',
                  amountRs:
                      dashCountResultData?.receipts!.totalAmt.toString() ?? '0',
                ),
                DashboardListModel(
                  title:
                      userType == Constants.fieldagent ? 'myVisits' : 'myCalls',
                  subTitle: 'event',
                  image: ImageResource.vectorArrow,
                  count: dashCountResultData?.visits?.count.toString() ?? '0',
                  amountRs:
                      dashCountResultData?.visits?.totalAmt.toString() ?? '0',
                ),
                DashboardListModel(
                  title: 'myDeposists',
                  subTitle: '',
                  image: '',
                  count: '',
                  amountRs: '',
                ),
                DashboardListModel(
                  title: 'yardingSelfRelease',
                  subTitle: '',
                  image: '',
                  count: '',
                  amountRs: '',
                ),
              ]);
              emit(DashboardLoadedState());
            },
            failure: (NetworkExceptions? error) async {});
      }
    }

    if (event is PriorityFollowEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());
      // Here we clear and false the search result
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<DashboardEventsCaseResults> dashBoardData =
            await repository.getDashboardEventData('priority');
        await dashBoardData.when(
            success: (DashboardEventsCaseResults? result) async {
              priorityFollowUpData = result!;
              emit(PriorityFollowState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      // Disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is UntouchedCasesEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());
      // Here we clear and flase the search result
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<DashboardEventsCaseResults> dashBoardData =
            await repository.getDashboardEventData('untouched');
        await dashBoardData.when(
            success: (DashboardEventsCaseResults? result) async {
              untouchedCasesData = result!;
              emit(UntouchedCasesState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      //disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is BrokenPTPEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());
      // Here we clear and false the search results
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<DashboardEventsCaseResults> dashBoardData =
            await repository.getDashboardEventData('broken');
        await dashBoardData.when(
            success: (DashboardEventsCaseResults? result) async {
              brokenPTPData = result!;
              emit(BrokenPTPState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      // Disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is MyReceiptsEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());
      // Here we clear and false the search result
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<MyReceiptResult> dashBoardData =
            await repository.getMyReceiptData(selectedFilter);
        await dashBoardData.when(
            success: (MyReceiptResult? result) async {
              myReceiptsData = result!;
              emit(MyReceiptsState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      // Disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is ReceiptsApiEvent) {
      // Here we clear and false the search resulte
      searchResultList.clear();
      isShowSearchResult = false;
      emit(SelectedTimeperiodDataLoadingState());
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<MyReceiptResult> dashBoardData =
            await repository.getMyReceiptData(event.timePeriod);
        await dashBoardData.when(
            success: (MyReceiptResult? result) async {
              myReceiptsData = result!;
              emit(ReturnReceiptsApiState(returnData: result));
            },
            failure: (NetworkExceptions? error) async {});
      }
      emit(SelectedTimeperiodDataLoadedState());
    }

    if (event is MyVisitsEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());
      // Here we clear and false the search result
      searchResultList.clear();
      isShowSearchResult = false;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<MyVisitResult> dashBoardData =
            await repository.getVisitsOrCallData(selectedFilter!);
        await dashBoardData.when(
            success: (MyVisitResult? result) async {
              myVisitsData = result!;
              emit(MyVisitsState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      // Disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is MyVisitApiEvent) {
      // Here we clear and false the search result
      searchResultList.clear();
      isShowSearchResult = false;
      emit(SelectedTimeperiodDataLoadingState());
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<MyVisitResult> dashBoardData =
            await repository.getVisitsOrCallData(event.timePeriod);
        await dashBoardData.when(
            success: (MyVisitResult? result) async {
              myVisitsData = result!;
              emit(ReturnVisitsApiState(returnData: result));
            },
            failure: (NetworkExceptions? error) async {});
      }
      emit(SelectedTimeperiodDataLoadedState());
    }

    if (event is MyDepositsEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<DepositResult> dashBoardData =
            await repository.getMyDeposits(selectedFilter);
        await dashBoardData.when(
            success: (DepositResult? result) async {
              myDepositsData = result!;
              emit(MyDepositState());
            },
            failure: (NetworkExceptions? error) async {});
      }
      // Disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is DepositsApiEvent) {
      emit(SelectedTimeperiodDataLoadingState());
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<DepositResult> dashBoardData =
            await repository.getMyDeposits(event.timePeriod);
        await dashBoardData.when(
            success: (DepositResult? result) async {
              myDepositsData = result!;
            },
            failure: (NetworkExceptions? error) async {});
      }
      emit(SelectedTimeperiodDataLoadedState());
    }

    if (event is YardingAndSelfReleaseEvent) {
      //If you click dashboard card Enabled loading
      emit(ClickToCardLoadingState());
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        emit(NoInternetConnectionState());
      } else {
        final ApiResult<List<YardingResult>?> dashBoardData =
            await repository.getYardingData();
        await dashBoardData.when(
            success: (List<YardingResult>? result) async {
              yardingAndSelfReleaseData = result!;
              emit(YardingAndSelfReleaseState());
            },
            failure: (NetworkExceptions? error) async {});
      }

      // Disabled loading
      emit(ClickToCardLoadingState());
    }

    if (event is PostBankDepositDataEvent) {
      emit(DisableMDBankSubmitBtnState());
      final ApiResult<dynamic> dashBoardData =
          await repository.postBankDepositData(event.fileData, event.postData);
      await dashBoardData.when(
          success: (dynamic result) async {
            emit(PostDataApiSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
      emit(EnableMDBankSubmitBtnState());
    }

    if (event is PostCompanyDepositDataEvent) {
      emit(DisableMDCompanyBranchSubmitBtnState());
      final ApiResult<dynamic> dashBoardData = await repository
          .postCompanyBranchData(event.fileData, event.postData);
      await dashBoardData.when(
          success: (dynamic result) async {
            emit(PostDataApiSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
      emit(EnableMDCompanyBranchSubmitBtnState());
    }

    if (event is PostYardingDataEvent) {
      emit(DisableRSYardingSubmitBtnState());
      final ApiResult<dynamic> dashBoardData = await repository.yardReleaseData(
          event.fileData, event.postData, 'yarding');
      //yarding
      await dashBoardData.when(
          success: (dynamic result) async {
            emit(PostDataApiSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
      emit(EnableRSYardingSubmitBtnState());
    }

    if (event is PostSelfReleaseDataEvent) {
      emit(DisableRSSelfReleaseSubmitBtnState());
      //selfRelease
      final ApiResult<dynamic> dashBoardData = await repository.yardReleaseData(
          event.fileData, event.postData, 'selfRelease');
      await dashBoardData.when(
          success: (dynamic result) async {
            emit(PostDataApiSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
      emit(EnableRSSelfReleaseSubmitBtnState());
    }

    if (event is NavigateCaseDetailEvent) {
      emit(NavigateCaseDetailState(
        paramValues: event.paramValues,
        unTouched: event.isUnTouched,
        isPriorityFollowUp: event.isPriorityFollowUp,
        isBrokenPTP: event.isBrokenPTP,
        isMyReceipts: event.isMyReceipts,
      ));
    }

    if (event is UpdateUnTouchedCasesEvent) {
      untouchedCasesData.count = untouchedCasesData.count! - 1;
      dashboardList[1].count =
          (int.parse(dashboardList[1].count!) - 1).toString();

      dashboardList[1].amountRs =
          (double.parse(dashboardList[1].amountRs!) - event.caseAmount)
              .toString();
      untouchedCasesData.totalAmt =
          untouchedCasesData.totalAmt! - event.caseAmount;

      untouchedCasesData.cases!
          .removeWhere((element) => element.caseId == event.caseId);

      emit(UpdateSuccessfulState());
    }
    if (event is UpdateBrokenCasesEvent) {
      brokenPTPData.count = brokenPTPData.count! - 1;
      dashboardList[2].count =
          (int.parse(dashboardList[2].count!) - 1).toString();

      dashboardList[2].amountRs =
          (int.parse(dashboardList[2].amountRs!) - event.caseAmount).toString();
      brokenPTPData.totalAmt = brokenPTPData.totalAmt! - event.caseAmount;
      brokenPTPData.cases!
          .removeWhere((element) => element.caseId == event.caseId);

      emit(UpdateSuccessfulState());
    }
    if (event is UpdatePriorityFollowUpCasesEvent) {
      priorityFollowUpData.count = priorityFollowUpData.count! - 1;
      dashboardList[0].count =
          (int.parse(dashboardList[0].count!) - 1).toString();

      dashboardList[0].amountRs =
          (int.parse(dashboardList[0].amountRs!) - event.caseAmount).toString();
      priorityFollowUpData.totalAmt =
          priorityFollowUpData.totalAmt! - event.caseAmount;

      priorityFollowUpData.cases!
          .removeWhere((element) => element.caseId == event.caseId);
      emit(UpdateSuccessfulState());
    }

    if (event is UpdateMyVisitCasesEvent) {
      dashboardList[4].count =
          (int.parse(dashboardList[4].count!) + 1).toString();
      if (event.isNotMyReceipts) {
        dashboardList[4].amountRs =
            (double.parse(dashboardList[4].amountRs!) + event.caseAmount)
                .toString();
      }
      emit(UpdateSuccessfulState());
    }
    if (event is UpdateMyReceiptsCasesEvent) {
      dashboardList[3].count =
          (int.parse(dashboardList[3].count!) + 1).toString();
      dashboardList[3].amountRs =
          (int.parse(dashboardList[3].amountRs!) + event.caseAmount).toString();
      emit(UpdateSuccessfulState());
    }

    if (event is NavigateSearchEvent) {
      emit(NavigateSearchState());
    }

    if (event is SetTimePeriodValueEvent) {
      emit(SetTimeperiodValueState());
    }

    if (event is HelpEvent) {
      emit(HelpState());
    }

    if (event is AddFilterTimePeriodFromNotification) {
      filterOption.addAll([
        FilterCasesByTimePeriod(timePeriodText: 'today', value: '0'),
        FilterCasesByTimePeriod(timePeriodText: 'weekly', value: '1'),
        FilterCasesByTimePeriod(timePeriodText: 'monthly', value: '2'),
      ]);
    }


    //todo search
    // if (event is SearchReturnDataEvent) {
    //   emit(SelectedTimeperiodDataLoadingState());
    //
    //   if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
    //     emit(NoInternetConnectionState());
    //   } else {
    //     final data = event.returnValue as SearchingDataModel;
    //     Map<String, dynamic> getSearchResultData;
    //     if (data.isStarCases! && data.isMyRecentActivity!) {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           HttpUrl.searchUrl +
    //               'starredOnly=${data.isStarCases}&' +
    //               'recentActivity=${data.isMyRecentActivity}&' +
    //               'accNo=${data.accountNumber}&' +
    //               'cust=${data.customerName}&' +
    //               'dpdStr=${data.dpdBucket}&' +
    //               'customerId=${data.customerID}&' +
    //               'pincode=${data.pincode}&' +
    //               'collSubStatus=${data.status}',
    //           encrypt: true);
    //     } else if (data.isStarCases!) {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           HttpUrl.searchUrl +
    //               'starredOnly=${data.isStarCases}&' +
    //               'accNo=${data.accountNumber}&' +
    //               'cust=${data.customerName}&' +
    //               'dpdStr=${data.dpdBucket}&' +
    //               'customerId=${data.customerID}&' +
    //               'pincode=${data.pincode}&' +
    //               'collSubStatus=${data.status}',
    //           encrypt: true);
    //     } else if (data.isMyRecentActivity!) {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           HttpUrl.searchUrl +
    //               'recentActivity=${data.isMyRecentActivity}&' +
    //               'accNo=${data.accountNumber}&' +
    //               'cust=${data.customerName}&' +
    //               'dpdStr=${data.dpdBucket}&' +
    //               'customerId=${data.customerID}&' +
    //               'pincode=${data.pincode}&' +
    //               'collSubStatus=${data.status}',
    //           encrypt: true);
    //     } else {
    //       getSearchResultData = await APIRepository.apiRequest(
    //           APIRequestType.get,
    //           HttpUrl.searchUrl +
    //               'accNo=${data.accountNumber}&' +
    //               'cust=${data.customerName}&' +
    //               'dpdStr=${data.dpdBucket}&' +
    //               'customerId=${data.customerID}&' +
    //               'pincode=${data.pincode}&' +
    //               'collSubStatus=${data.status}',
    //           encrypt: true);
    //     }
    //
    //     // Map<String, dynamic> getSearchResultData =
    //     //     await APIRepository.apiRequest(
    //     //         APIRequestType.get,
    //     //         HttpUrl.searchUrl +
    //     //             "starredOnly=${event.returnValue.isStarCases}&" +
    //     //             "recentActivity=${event.returnValue.isMyRecentActivity}&" +
    //     //             "accNo=${event.returnValue.accountNumber}&" +
    //     //             "cust=${event.returnValue.customerName}&" +
    //     //             "dpdStr=${event.returnValue.dpdBucket}&" +
    //     //             "customerId=${event.returnValue.customerID}&" +
    //     //             "pincode=${event.returnValue.pincode}&" +
    //     //             "collSubStatus=${event.returnValue.status}");
    //
    //     searchResultList.clear();
    //     isShowSearchResult = true;
    //
    //     for (var element in getSearchResultData['data']['result']) {
    //       searchResultList
    //           .add(Result.fromJson(jsonDecode(jsonEncode(element))));
    //     }
    //
    //     emit(SelectedTimeperiodDataLoadedState());
    //
    //     emit(GetSearchDataState());
    //   }
    // }
  }
}
