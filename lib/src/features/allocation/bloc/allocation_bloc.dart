import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:domain_models/response_models/mapView/map_model.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repository/allocation_repository.dart';
import 'package:repository/case_repository.dart';

part 'allocation_event.dart';

part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc({required this.repository, required this.caseRepository})
      : super(AllocationInitial()) {
    on<AllocationEvent>(_onEvent);
  }

  AllocationRepository repository;
  CaseRepository caseRepository;

  List<String> filterBuildRoute = <String>[
    StringResource.all,
    StringResource.under5km,
    StringResource.more5km,
  ];

  int pageKey = 0;
  int tab = 0;
  int buildRouteSubTab = 0;
  bool isRefresh = false;

  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );
  String? currentAddress;
  static const _pageSize = 20;
  List<dynamic> multipleLatLong = <dynamic>[];

  Future<void> _onEvent(
      AllocationEvent event, Emitter<AllocationState> emit) async {
    if (event is InitialCurrentLocationEvent) {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        final Position result = await Geolocator.getCurrentPosition();

        position = result;

        final List<Placemark> placeMarks =
            await placemarkFromCoordinates(result.latitude, result.longitude);

        currentAddress =
            '${placeMarks.toList().first.street}, ${placeMarks.toList().first.subLocality}, ${placeMarks.toList().first.postalCode}';

        // await repository.putCurrentLocation(event.position.latitude,event.position.longitude);
      } else {
        await openAppSettings();
      }
    }

    if (event is AllocationTabLoadedEvent) {
      emit(AllocationTabLoadedState(event.tabLoaded));
    }

    if (event is NavigateSearchPageEvent) {
      emit(NavigateSearchPageState());
    }

    if (event is AllocationTabClicked) {
      isRefresh=true;
      tab = event.tab;
      emit(AllocationTabClickedState());
    }
    if (event is BuildRouteFilterClickedEvent) {
      isRefresh=true;
      buildRouteSubTab = event.index;
      emit(BuildRouteFilterClickedState());
    }

    if (event is MapViewEvent) {
      {
        emit(MapViewLoadingState());

        final newItems = await caseRepository.getBuildRouteCases(
            _pageSize, event.pageKey, event.paramValues);
        await newItems.when(
            success: (List<PriorityCaseListModel>? result) async {
              multipleLatLong.clear();
              if (result != null) {
                result.forEach((element) {
                  multipleLatLong.add(
                    MapMarkerModel(
                      caseId: element.caseId,
                      address: element.address?.first.value,
                      due: element.due.toString(),
                      name: element.cust,
                      latitude: element.location?.lat,
                      longitude: element.location?.lng,
                    ),
                  );
                });
              }
            },
            failure: (NetworkExceptions? error) async {});
        emit(MapViewState());
      }
    }
  }
}
