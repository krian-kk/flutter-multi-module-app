import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/models/build_route_model/build_route_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/search_model/search_model.dart';
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

  Future<Box<OrigoDynamicTable>> offlineDatabaseBox =
      Hive.openBox<OrigoDynamicTable>('testBox4');

  List starCount = [];

  @override
  Stream<AllocationState> mapEventToState(AllocationEvent event) async* {
    if (event is AllocationInitialEvent) {
      yield AllocationLoadingState();

      List<Result> resultList = [];

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, dynamic> priorityListData =
            await APIRepository.getpriorityCaseList();
        // Map<String, dynamic> getbuildRouteData =
        //     await APIRepository.getBuildRouteList('', '', '');

        // Build Route Api
        Map<String, dynamic> getbuildRouteData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.buildRouteUrl + '5000');
        buildRouteData = BuildRouteModel.fromJson(
            getbuildRouteData['data'] as Map<String, dynamic>);

        // =====

        await offlineDatabaseBox.whenComplete(() {
          offlineDatabaseBox.then((value) {
            value.put(
              'priority_caselist',
              OrigoDynamicTable(
                message: priorityListData['message'],
                status: priorityListData['status'],
                result: priorityListData['result'] as List<dynamic>,
              ),
            );
            for (var element in value.get('priority_caselist')!.result) {
              resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
              if (Result.fromJson(jsonDecode(jsonEncode(element)))
                      .starredCase ==
                  true) {
                starCount.add(Result.fromJson(jsonDecode(jsonEncode(element)))
                    .starredCase);
              }
            }
          });
        });
      } else {
        await offlineDatabaseBox.then((value) {
          for (var element in value.get('priority_caselist')!.result) {
            resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
            if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
                true) {
              starCount.add(
                  Result.fromJson(jsonDecode(jsonEncode(element))).starredCase);
            }
          }
        });
      }
      // allocationList.addAll([
      //   AllocationListModel(
      //     newlyAdded: true,
      //     customerName: 'Debashish Patnaik',
      //     amount: '₹ 3,97,553.67',
      //     address: '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
      //     date: 'Today, Thu 18 Oct, 2021',
      //     loanID: 'TVS / TVSF_BFRT6524869550',
      //   ),
      //   AllocationListModel(
      //     newlyAdded: true,
      //     customerName: 'New User',
      //     amount: '₹ 5,54,433.67',
      //     address: '2/345, 6th Main Road, Bangalore - 534544',
      //     date: 'Thu, Thu 18 Oct, 2021',
      //     loanID: 'TVS / TVSF_BFRT6524869550',
      //   ),
      //   AllocationListModel(
      //     newlyAdded: true,
      //     customerName: 'Debashish Patnaik',
      //     amount: '₹ 8,97,553.67',
      //     address: '2/345, 1th Main Road Guindy, Chenai - 875032',
      //     date: 'Sat, Thu 18 Oct, 2021',
      //     loanID: 'TVS / TVSF_BFRT6524869550',
      //   ),
      // ]);
      yield AllocationLoadedState(successResponse: resultList);
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
      yield NavigateCaseDetailState();
    }

    if (event is FilterSelectOptionEvent) {
      yield FilterSelectOptionState();
      selectedOption = 0;
    }
    if (event is ClickAllocationSearchButtonEvent) {
      yield SearchAllocationScreenLoadedState();
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        print('Please Connect Internet!');
        yield SearchAllocationFailedState('Please Connect Internet!');
      } else {
        // Map<String, dynamic> getSearchData =
        //     await APIRepository.getSearchData(event.searchField);
        Map<String, dynamic> getSearchData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.searchUrl + 'MOR000800314934');
        searchData = SearchModel.fromJson(getSearchData['data']);
        yield SearchAllocationScreenSuccessState(searchData);
      }
    }
  }
}
