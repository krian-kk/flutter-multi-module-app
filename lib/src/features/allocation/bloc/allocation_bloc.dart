import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:design_system/constant_event_values.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:domain_models/request_body/allocation/are_you_at_office_model.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:domain_models/response_models/mapView/map_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preference_helper/preference_helper.dart';
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

  late List<String> filterBuildRoute;

  int pageKey = 0;
  int tab = 0;
  int buildRouteSubTab = 0;
  bool isRefresh = false;
  bool areYouAtOffice = true;
  bool isSubmitRUOffice = false;

  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );
  String? currentAddress;
  static const _pageSize = 20;
  List<dynamic> multipleLatLong = <dynamic>[];
  String? userType;

  Future<void> _onEvent(
      AllocationEvent event, Emitter<AllocationState> emit) async {
    if (event is AllocationInitialEvent) {
      emit(AllocationLoadingState());

      List<String?> initialData = await repository.allocationInitialData();
      userType = initialData[0]!;

      await PreferenceHelper.getString(keyPair: 'ruAtOfficeDay')
          .then((value) async {
        if (value != DateTime.now().day.toString()) {
          await PreferenceHelper.getBool(keyPair: 'areyouatOffice')
              .then((value) {
            areYouAtOffice = value;
          });
        } else {
          areYouAtOffice = false;
        }
      });

      filterBuildRoute = <String>[
        StringResource.all,
        StringResource.under5km,
        StringResource.more5km,
      ];

      emit(AllocationLoadedState());
    }

    if (event is InitialCurrentLocationEvent) {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        final Position result = await Geolocator.getCurrentPosition();

        position = result;

        final List<Placemark> placeMarks =
            await placemarkFromCoordinates(result.latitude, result.longitude);

        currentAddress =
            '${placeMarks.toList().first.street}, ${placeMarks.toList().first.subLocality}, ${placeMarks.toList().first.postalCode}';

        await repository.putCurrentLocation(
            position.latitude, position.longitude);
        emit(UpdatedCurrentLocationState());
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
      isRefresh = true;
      tab = event.tab;
      emit(AllocationTabClickedState());
    }
    if (event is BuildRouteFilterClickedEvent) {
      isRefresh = true;
      buildRouteSubTab = event.index;
      emit(BuildRouteFilterClickedState());
    }

    if (event is TapAreYouAtOfficeOptionsEvent) {
      isSubmitRUOffice = true;
      emit(AreYouAtOfficeLoadingState());

      Position positions = Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      if (Geolocator.checkPermission().toString() !=
          PermissionStatus.granted.toString()) {
        final Position res = await Geolocator.getCurrentPosition();
        positions = res;
      }
      final requestBodyData = AreYouAtOfficeModel(
        eventId: ConstantEventValues.areYouAtOfficeEventId,
        eventType: 'Office Check In',
        eventAttr: AreYouAtOfficeEventAttr(
          altitude: positions.altitude,
          accuracy: positions.accuracy,
          heading: positions.heading,
          speed: positions.speed,
          latitude: positions.latitude,
          longitude: positions.longitude,
        ),
        createdBy: Singleton.instance.agentRef ?? '',
        agentName: Singleton.instance.agentName ?? '',
        contractor: Singleton.instance.contractor ?? '',
        eventModule: 'Field Allocation',
        eventCode: ConstantEventValues.areYouAtOfficeEvenCode,
      );

      final ApiResult<BaseResponse> data =
          await repository.areYouAtOffice(requestBodyData);
      await data.when(success: (BaseResponse? data) async {
        isSubmitRUOffice = false;
        areYouAtOffice = false;
        PreferenceHelper.setPreference('areyouatOffice', false);
        PreferenceHelper.setPreference(
            'ruAtOfficeDay', DateTime.now().day.toString());
        emit(TapAreYouAtOfficeOptionsSuccessState());
      }, failure: (NetworkExceptions? error) async {
        isSubmitRUOffice = false;
        areYouAtOffice = true;
        emit(TapAreYouAtOfficeOptionsFailureState());
      });
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
