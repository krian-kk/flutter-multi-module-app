import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/event_details_model/display_eventdetails_model.dart';
import 'package:origa/models/event_details_model/event_details_model.dart';
import 'package:origa/models/event_details_model/result.dart';
import 'package:origa/models/play_audio_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_format_utils.dart';

part 'event_details_event.dart';

part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  List<EventModel> eventList = [];

  EventDetailsBloc() : super(EventDetailsInitial()) {
    eventList = [];
    on<EventDetailsEvent>(
        (EventDetailsEvent event, Emitter<EventDetailsState> emit) async {
      if (event is EventDetailsInitialEvent) {
        emit.call(EventDetailsLoadingState());
        if (ConnectivityResult.none ==
            await Connectivity().checkConnectivity()) {
          // yield CDNoInternetState();
          //Getting event details from firebase databse
          await FirebaseFirestore.instance
              .collection(Singleton.instance.firebaseDatabaseName)
              .doc(Singleton.instance.agentRef)
              .collection(Constants
                  .firebaseEvent) // To get the events from event collection
              .orderBy('createdAt', descending: true)
              .where(Constants.caseId,
                  isEqualTo:
                      event.caseId) //To find respective events of case details
              .limit(5) // Need to show the last five events only
              .get()
              .then((QuerySnapshot<Map<String, dynamic>> value) {
            if (value.docs.isNotEmpty) {
              //temporaryList for events list
              // ignore: prefer_final_locals
              List<EvnetDetailsResultsModel>? results =
                  <EvnetDetailsResultsModel>[];
              for (QueryDocumentSnapshot<Map<String, dynamic>> element
                  in value.docs) {
                debugPrint('element--> ${element.data()}');
                try {
                  results
                      .add(EvnetDetailsResultsModel.fromJson(element.data()));
                } catch (e) {
                  debugPrint(e.toString());
                }
              }
              eventDetailsAPIValues.result = results.reversed.toList();
              // eventDetailsAPIValues.result =
              //     eventDetailsAPIValues.result!.reversed.toList();
            } else {
              eventDetailsAPIValues.result = <EvnetDetailsResultsModel>[];
            }
          });
        } else {
          final Map<String, dynamic> getEventDetailsData =
              await APIRepository.apiRequest(
                  APIRequestType.get,
                  HttpUrl.eventDetailsUrl(
                      caseId: event.caseId, userType: event.userType));

          if (getEventDetailsData[Constants.success] == true) {
            final Map<String, dynamic> jsonData = getEventDetailsData['data'];
            eventDetailsAPIValues = EventDetailsModel.fromJson(jsonData);
          } else {
            AppUtils.showToast(getEventDetailsData['data']['message']);
          }
        }
        // if (ConnectivityResult.none ==
        //     await Connectivity().checkConnectivity()) {
        //   emit.call(NoInternetState());
        // } else {
        //   Map<String, dynamic> getEventDetailsData =
        //       await APIRepository.apiRequest(
        //           APIRequestType.get,
        //           HttpUrl.eventDetailsUrl(
        //             caseId: event.caseId,
        //             userType: event.userType,
        //           ));

        //   if (getEventDetailsData[Constants.success] == true) {
        //     Map<String, dynamic> jsonData = getEventDetailsData['data'];

        //     eventDetailsAPIValue = EventDetailsApiModel.fromJson(jsonData);
        //   } else {
        //     AppUtils.showToast(getEventDetailsData['data']['message']);
        //   }
        // }

        //play audio list
        // eventDetailsAPIValues.result
        //     ?.forEach((EvnetDetailsResultsModel element) {
        //   eventDetailsPlayAudioModel.add(EventDetailsPlayAudioModel());
        // });
        eventDetailsAPIValues.result!.sort((a, b) {
          return a.createdAt
              .toString()
              .toLowerCase()
              .compareTo(b.createdAt.toString().toLowerCase());
        });
      }

      releaseDateMap =
          eventDetailsAPIValues.result!.groupBy((m) => m.monthName);
      final List<Map> data = [];
      releaseDateMap.forEach((key, value) {
        // debugPrint('key--> $key value--> ${value}');
        final map = {
          'month': key,
          'eventList': value,
        };
        data.add(jsonDecode(jsonEncode(map)));
      });
      displayEventDetail = data
          .map((item) => EventResult.fromJson(item as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();
      // debugPrint('--------> ${jsonEncode(displayEventDetail)}');

      // eventDetailsAPIValues.result!.forEach((element) {
      //   debugPrint('element--> ${element.monthName}');
      // });
      emit.call(EventDetailsLoadedState());
    });
  }

  Map releaseDateMap = {};
  EventDetailsModel eventDetailsAPIValues = EventDetailsModel();
  List<EventDetailsPlayAudioModel> eventDetailsPlayAudioModel =
      <EventDetailsPlayAudioModel>[];
  List<EventResult> displayEventDetail = [];
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
