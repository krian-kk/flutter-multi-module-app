import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/models/auto_calling_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/priority_case_list.dart';

part 'allocation_t_event.dart';
part 'allocation_t_state.dart';

class AllocationTBloc extends Bloc<AllocationTEvent, AllocationTState> {
  AllocationTBloc() : super(AllocationTInitial());

  int selectedOption = 0;
  bool isEnableSearchButton = true;
  bool isEnableStartCallButton = false;
  List<AllocationListModel> allocationList = [];
  List<AutoCallingModel> mobileNumberList = [];
  dynamic valuesForDynamicBloc;

  List<String> selectOptions = [
    StringResource.priority,
    StringResource.autoCalling,
  ];

  List<String> listOfContacts = [
    '9765431239',
    '9765431239',
    '9765431239',
    '9765431239',
  ];

  String? userType;
  String? agentName;
  String? agrRef;
  bool isShowSearchPincode = false;
  bool isNoInternet = false;

  List starCount = [];
  List<Result> resultList = [];

  int page = 1;

  // There is next page or not
  bool hasNextPage = true;

  @override
  Stream<AllocationTState> mapEventToState(AllocationTEvent event) async* {
    if (event is AllocationTInitialEvent) {
      yield AllocationTLoadingState();
      SharedPreferences _pref = await SharedPreferences.getInstance();
      Singleton.instance.buildContext = event.context;
      userType = _pref.getString(Constants.userType);
      agentName = _pref.getString(Constants.agentName);
      agrRef = _pref.getString(Constants.agentRef);
      isShowSearchPincode = false;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternet = true;
        yield NoInternetConnectionState();
      } else {
        isNoInternet = false;

        Map<String, dynamic> priorityListData = await APIRepository.apiRequest(
          APIRequestType.GET,
          HttpUrl.priorityCaseList +
              'pageNo=${Constants.pageNo}' +
              '&limit=${Constants.limit}' +
              "&userType=$userType",
        );

        resultList.clear();
        starCount.clear();

        for (var element in priorityListData['data']['result']) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount.add(
                Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
          }

          print("--------------NK--------Telecaller");
          print(resultList.toString());
        }

        mobileNumberList.addAll([
          AutoCallingModel(
            mobileNumber: '9876321230',
            callResponse: 'Declined Call',
          ),
          AutoCallingModel(
            mobileNumber: '9876321230',
          ),
          AutoCallingModel(
            mobileNumber: '9876321230',
          ),
        ]);

        yield AllocationTLoadedState(successResponse: resultList);
      }
    }

    if (event is TapPriorityTEvent) {
      yield CaseListViewLoadingState();

      page = 1;
      hasNextPage = true;

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
        }
      }
      yield TapPriorityTState(successResponse: resultList);
    }

    if (event is PriorityLoadMoreTEvent) {
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
          }
          hasNextPage = false;
        }
      }
      yield PriorityLoadMoreTState(successResponse: resultList);
    }

    if (event is NavigateSearchPageTEvent) {
      yield NavigateSearchPageTState();
    }

    if (event is NavigateCaseDetailTEvent) {
      yield NavigateCaseDetailTState(event.paramValue);
    }
    if (event is ClickCaseDetailsEvent) {
      yield ClickCaseDetailsState(event.paramValue);
    }
    if (event is ClickPhoneTelecallerEvent) {
      yield ClickPhoneTelecallerState();
    }
  }
}
