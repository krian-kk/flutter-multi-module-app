import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mime/mime.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/constants.dart';

import '../models/priority_case_list.dart';

class FirebaseUtils {
  static Future<List<Result>> caseDetailStream() async {
    List<Result> resultList = [];
    FirebaseFirestore.instance
        .collection(Singleton.instance.firebaseDatabaseName)
        .doc(Singleton.instance.agentRef)
        .collection(Constants.firebaseCase)
        .snapshots()
        .forEach((element) {
      for (var docs in element.docs) {
        Map<String, dynamic>? data = docs.data();
        resultList.add(Result.fromJson(data));
      }
    });
    return resultList;
  }

  // to get the events history using case id
  static Future<bool> storeEvents(
      {dynamic eventsDetails,
      dynamic caseId,
      String? selectedClipValue,
      String? selectedFollowUpDate}) async {
    bool returnValues = false;
    if (Singleton.instance.usertype == Constants.fieldagent) {
      FirebaseFirestore.instance
          .collection(Singleton.instance.firebaseDatabaseName)
          .doc(Singleton.instance.agentRef)
          .collection(Constants.firebaseEvent)
          .add(eventsDetails);
      if (selectedClipValue != null &&
          selectedClipValue != Constants.collections) {
        FirebaseFirestore.instance
            .collection(Singleton.instance.firebaseDatabaseName)
            .doc(Singleton.instance.agentRef)
            .collection(Constants.firebaseCase)
            .doc(caseId)
            .update(
              selectedFollowUpDate == null
                  ? {'collSubStatus': selectedClipValue}
                  : {
                      'fieldfollowUpDate': selectedFollowUpDate,
                      'collSubStatus': selectedClipValue
                    },
            );
      }
      returnValues = true;
    } else {
      returnValues = false;
    }
    return returnValues;
  }

  // to update the case detail starred cases or not
  static Future<bool> updateStarred({dynamic isStarred, dynamic caseId}) async {
    bool returnValues = false;
    if (Singleton.instance.usertype == Constants.fieldagent) {
      await FirebaseFirestore.instance
          .collection(Singleton.instance.firebaseDatabaseName)
          .doc(Singleton.instance.agentRef)
          .collection(Constants.firebaseCase)
          .doc(caseId)
          .update({'starredCase': isStarred});
      returnValues = true;
    } else {
      returnValues = false;
    }
    return returnValues;
  }

  //For offline purpose -> it'll storing inside of all event submission if files added
  static Map<String, dynamic> toPrepareFileStoringModel(List<File> files) {
    List<Map<String, dynamic>> returnResult = [];
    for (var element in files) {
      returnResult.add({
        'fileName': element.path.split('/').last,
        'base64String': base64Encode(element.readAsBytesSync()),
        'mimeType': lookupMimeType(element.path)
      });
    }
    return {'events': returnResult};
  }
}
