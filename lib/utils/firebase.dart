// ignore_for_file: unawaited_futures

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
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
    eventMap['dateTime'] = DateTime.now();
    if (Singleton.instance.usertype == Constants.fieldagent) {
      FirebaseFirestore.instance
          .collection(Singleton.instance.firebaseDatabaseName)
          .doc(Singleton.instance.agentRef)
          .collection(Constants.firebaseEvent)
          .add(eventMap);

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

        FirebaseFirestore.instance
            .collection(Singleton.instance.firebaseDatabaseName)
            .doc(Singleton.instance.agentRef)
            .collection(Constants.firebaseCase)
            .doc(caseId)
            .snapshots()
            .forEach((element) {
          element.data()!.forEach((key, value) {
            if (key == 'addressDetails') {
              final Map selectedAddress = bloc.selectedAddressModel;
              value.asMap().forEach((index, values) {
                final Map addressModel = Map.from(values);
                if (selectedAddress['value'] == addressModel['value']) {
                  indexNumber = index;
                  debugPrint(indexNumber.toString());
                } else {
                  toUpdateValues.add(addressModel);
                }
              });
            }
          });
        });
        FirebaseFirestore.instance
            .collection(Singleton.instance.firebaseDatabaseName)
            .doc(Singleton.instance.agentRef)
            .collection(Constants.firebaseCase)
            .doc(caseId)
            .update(selectedFollowUpDate == null
                ? {
                    'collSubStatus': selectedClipValue,
                    'addressDetails': toUpdateValues
                  }
                : {
                    'fieldfollowUpDate': selectedFollowUpDate,
                    'collSubStatus': selectedClipValue,
                    'addressDetails': toUpdateValues,
                  });

        FirebaseFirestore.instance
            .collection(Singleton.instance.firebaseDatabaseName)
            .doc(Singleton.instance.agentRef)
            .collection(Constants.firebaseCase)
            .doc(caseId)
            .snapshots()
            .first
            .then((value) {
          final mapValues = value.data() as Map<String, dynamic>;
          // debugPrint('After update values--> ${mapValues['addressDetails']}');
          debugPrint(
              'collSubStatus update values--> ${mapValues['collSubStatus']}');
          debugPrint('selectedClipValue--> $selectedClipValue');
        });
      }
      returnValues = true;
    } else {
      returnValues = false;
    }
    return returnValues;
  }

  // to update the case detail starred cases or not
  static updateStarred({dynamic isStarred, dynamic caseId}) async {
    if (Singleton.instance.usertype == Constants.fieldagent) {
      await FirebaseFirestore.instance
          .collection(Singleton.instance.firebaseDatabaseName)
          .doc(Singleton.instance.agentRef)
          .collection(Constants.firebaseCase)
          .doc(caseId)
          .snapshots()
          .first
          .then((value) {
        final mapValues = value.data() as Map<String, dynamic>;
        if (mapValues['starredCase'] != null) {
          if (mapValues['starredCase']) {
            isStarred = false;
          } else {
            isStarred = true;
          }
        } else {
          mapValues['starredCase'] = true;
        }
      });
      FirebaseFirestore.instance
          .collection(Singleton.instance.firebaseDatabaseName)
          .doc(Singleton.instance.agentRef)
          .collection(Constants.firebaseCase)
          .doc(caseId)
          .update({'starredCase': isStarred});
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
}
