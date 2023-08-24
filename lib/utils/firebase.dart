// ignore_for_file: unawaited_futures

import 'dart:convert';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/main.dart';
import 'package:origa/models/event_details_model/result.dart';
import 'package:origa/models/offline_priority_response_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/constants.dart';

class FirebaseUtils {
  // to get the events history using case id
  //Address health -> 2 = customer met, 1 = Customer not met, 0 = invalid
  static Future<bool> storeEvents(
      {dynamic eventsDetails,
      dynamic caseId,
      String? selectedClipValue,
      String? selectedFollowUpDate,
      required CaseDetailsBloc bloc}) async {
    bool returnValues = false;
    final eventMap = eventsDetails as Map<String, dynamic>;
    eventMap['createdAt'] = DateTime.now().toIso8601String();
    if (Singleton.instance.usertype == Constants.fieldagent &&
        Singleton.instance.isOfflineEnabledContractorBased) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        debugPrint('--------> $eventMap');
        // if (eventMap['contact'] != null) {
        //   var eventAddress = eventMap['contact'];
        //   eventMap['contact'] = Map.of(eventAddress);
        // }
        // FirebaseFirestore.instance
        //     .collection(Singleton.instance.firebaseDatabaseName)
        //     .doc(Singleton.instance.agentRef)
        //     .collection(Constants.firebaseEvent)
        //     .add(eventMap);

        if (selectedClipValue != null &&
            selectedClipValue != Constants.collections) {
          var indexNumber = 0;

          final List<Map> toUpdateValues = [];
          final UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));
          var status = 0;
          switch (data.tabIndex) {
            case 0:
              status = 2;
              break;
            case 1:
              status = 1;
              break;
            case 2:
              status = 0;
              break;
            default:
              status = int.parse(data.currentHealth);
              break;
          }
          bloc.selectedAddressModel['health'] = status.toString();
          toUpdateValues.add(bloc.selectedAddressModel);

          // FirebaseFirestore.instance
          //     .collection(Singleton.instance.firebaseDatabaseName)
          //     .doc(Singleton.instance.agentRef)
          //     .collection(Constants.firebaseCase)
          //     .doc(caseId)
          //     .snapshots()
          //     .forEach((element) {
          //   element.data()?.forEach((key, value) {
          //     if (key == 'addressDetails') {
          //       final Map selectedAddress = bloc.selectedAddressModel;
          //       value.asMap().forEach((index, values) {
          //         final Map addressModel = Map.from(values);
          //         if (selectedAddress['value'] == addressModel['value']) {
          //           indexNumber = index;
          //           debugPrint(indexNumber.toString());
          //         } else {
          //           toUpdateValues.add(addressModel);
          //         }
          //       });
          //     }
          //   });
          // });
          // FirebaseFirestore.instance
          //     .collection(Singleton.instance.firebaseDatabaseName)
          //     .doc(Singleton.instance.agentRef)
          //     .collection(Constants.firebaseCase)
          //     .doc(caseId)
          //     .update(selectedFollowUpDate == null
          //         ? {
          //             'collSubStatus': selectedClipValue,
          //             'addressDetails': toUpdateValues
          //           }
          //         : {
          //             'fieldfollowUpDate': selectedFollowUpDate,
          //             'collSubStatus': selectedClipValue,
          //             'addressDetails': toUpdateValues,
          //           });
          //
          // FirebaseFirestore.instance
          //     .collection(Singleton.instance.firebaseDatabaseName)
          //     .doc(Singleton.instance.agentRef)
          //     .collection(Constants.firebaseCase)
          //     .doc(caseId)
          //     .snapshots()
          //     .first
          //     .then((value) {
          //   final mapValues = value.data() as Map<String, dynamic>;
          //   debugPrint('After update values--> ${mapValues['addressDetails']}');
            // debugPrint(
            //     'collSubStatus update values--> ${mapValues['collSubStatus']}');
            // debugPrint('selectedClipValue--> $selectedClipValue');
          // });
        }
        // returnValues = true;
      } else {
        returnValues = true;
        // priority();
      }
      returnValues = false;
    } else {
      returnValues = false;
    }
    return returnValues;
  }

  // to update the case detail starred cases or not
  static updateStarred({dynamic isStarred, dynamic caseId}) async {
    if (Singleton.instance.usertype == Constants.fieldagent &&
        Singleton.instance.isOfflineEnabledContractorBased) {
      // await FirebaseFirestore.instance
      //     .collection(Singleton.instance.firebaseDatabaseName)
      //     .doc(Singleton.instance.agentRef)
      //     .collection(Constants.firebaseCase)
      //     .doc(caseId)
      //     .snapshots()
      //     .first
      //     .then((value) {
      //   final mapValues = value.data() as Map<String, dynamic>;
      //   if (mapValues['starredCase'] != null) {
      //     if (mapValues['starredCase']) {
      //       isStarred = false;
      //     } else {
      //       isStarred = true;
      //     }
      //   } else {
      //     mapValues['starredCase'] = true;
      //   }
      // });
      // FirebaseFirestore.instance
      //     .collection(Singleton.instance.firebaseDatabaseName)
      //     .doc(Singleton.instance.agentRef)
      //     .collection(Constants.firebaseCase)
      //     .doc(caseId)
      //     .update({'starredCase': isStarred});
    }
  }

  //For offline purpose -> it'll storing inside of all event submission if files added
  static Future<Map<String, dynamic>> toPrepareFileStoringModel(
      List<File> files) async {
    final List<Map<String, dynamic>> returnResult = [];
    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      for (var element in files) {
        returnResult.add({
          'fileName': element.path.split('/').last,
          'base64String': base64Encode(element.readAsBytesSync()),
          'mimeType': lookupMimeType(element.path)
        });
      }
    }
    return {'events': returnResult};
  }

  static streaming({required int count}) async {
    debugPrint('Firebase streaming method--> count-> $count');
    // await FirebaseDatabase.instanceFor(app: firebaseApp).goOnline();
    // FirebaseDatabase.instanceFor(app: firebaseApp).setPersistenceEnabled(true);
    // FirebaseDatabase.instanceFor(app: firebaseApp)
    //     .setPersistenceCacheSizeBytes(Settings.CACHE_SIZE_UNLIMITED);
    // final DatabaseReference scoresRef =
    //     FirebaseDatabase.instanceFor(app: firebaseApp)
    //         .ref(Singleton.instance.firebaseDatabaseName);
    // await scoresRef.keepSynced(true);
    // await FirebaseFirestore.instance
    //     .collection(Singleton.instance.firebaseDatabaseName)
    //     .doc(Singleton.instance.agentRef)
    //     .collection(Constants.firebaseCase)
    //     .limit(100)
    //     .get(const GetOptions(source: Source.server))
    //     .then((value) {
    //   debugPrint('Firebase asStream empty--> ${value.docs.length}');
    // });
    //
    // await FirebaseFirestore.instance
    //     .collection(Singleton.instance.firebaseDatabaseName)
    //     .doc(Singleton.instance.agentRef)
    //     .collection(Constants.firebaseCase)
    //     .limit(100)
    //     .snapshots()
    //     .take(5)
    //     .forEach((element) {
    //   debugPrint('Firebase event empty--> ${element.docs.length}');
    // });
    // await FirebaseDatabase.instance.goOnline();
    // FirebaseDatabase.instance.setPersistenceEnabled(true);
    // FirebaseDatabase.instance
    //     .setPersistenceCacheSizeBytes(Settings.CACHE_SIZE_UNLIMITED);
    // await scoresRef.keepSynced(true);
    debugPrint('Firebase streaming returned-->');
  }

  static Future<void> priority() async {
    final Map<String, dynamic> priorityListData =
        await APIRepository.apiRequest(
            APIRequestType.get, HttpUrl.priorityCaseListV2);
    if (priorityListData['success']) {
      dynamic offlinePriorityResponseModel;
      try {
        offlinePriorityResponseModel =
            OfflinePriorityResponseModel.fromJson(priorityListData['data']);
      } catch (e) {
        debugPrint(e.toString());
      }
      if (offlinePriorityResponseModel is OfflinePriorityResponseModel) {
        // FirebaseDatabase.instanceFor(app: firebaseApp)
        //     .setPersistenceEnabled(true);
        // await FirebaseFirestore.instance
        //     .collection(Singleton.instance.firebaseDatabaseName)
        //     .doc(Singleton.instance.agentRef)
        //     .collection(Constants.firebaseEvent)
        //     .get()
        //     .then((QuerySnapshot<Map<String, dynamic>> value) {
        //   if (value.docs.isNotEmpty) {
        //     for (QueryDocumentSnapshot<Map<String, dynamic>> element
        //         in value.docs) {
        //       try {
        //         debugPrint(
        //             'Event details case id--> ${EvnetDetailsResultsModel.fromJson(element.data()).eventType}');
        //       } catch (e) {
        //         debugPrint(e.toString());
        //       }
        //     }
        //   }
        // });
        //
        // await FirebaseFirestore.instance
        //     .collection(Singleton.instance.firebaseDatabaseName)
        //     .doc(Singleton.instance.agentRef)
        //     .collection(Constants.firebaseCase)
        //     .get()
        //     .then((value) {
        //   for (var element in value.docChanges) {
        //     debugPrint('Element--> $element');
        //   }
        // });
      }
    }
  }
}
