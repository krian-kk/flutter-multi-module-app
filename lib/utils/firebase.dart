import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/constants.dart';

import '../models/priority_case_list.dart';

class FirebaseUtils {
  static Future<List<Result>> caseDetailStream() async {
    final List<Result> resultList = [];
    await FirebaseFirestore.instance
        .collection(Singleton.instance.firebaseDatabaseName)
        .doc(Singleton.instance.agentRef)
        .collection(Constants.firebaseCase)
        .snapshots()
        .forEach((element) {
      for (var docs in element.docs) {
        final Map<String, dynamic>? data = docs.data();
        resultList.add(Result.fromJson(data!));
      }
    });
    return resultList;
  }

  // to get the events history using case id
  //Address health -> 2 = customer met, 1 = Customer not met, 0 = invalid
  static Future<bool> storeEvents(
      {dynamic eventsDetails,
      dynamic caseId,
      String? selectedClipValue,
      String? selectedFollowUpDate,
      required CaseDetailsBloc bloc}) async {
    const bool returnValues = false;
    // if (Singleton.instance.usertype == Constants.fieldagent
    //     // && Constants.appDataLoadedFromFirebase
    //     ) {
    //   FirebaseFirestore.instance
    //       .collection(Singleton.instance.firebaseDatabaseName)
    //       .doc(Singleton.instance.agentRef)
    //       .collection(Constants.firebaseEvent)
    //       .add(eventsDetails);
    //   if (selectedClipValue != null &&
    //       selectedClipValue != Constants.collections) {
    //     var indexNumber = 0;

    //     List<Map> toUpdateValues = [];
    //     UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
    //         Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));
    //     var status = 0;
    //     switch (data.tabIndex) {
    //       case 0:
    //         status = 2;
    //         break;
    //       case 1:
    //         status = 1;
    //         break;
    //       case 2:
    //         status = 0;
    //         break;
    //       default:
    //         status = int.parse(data.currentHealth);
    //         break;
    //     }
    //     bloc.selectedAddressModel['health'] = status.toString();
    //     toUpdateValues.add(bloc.selectedAddressModel);
    //     FirebaseFirestore.instance
    //         .collection(Singleton.instance.firebaseDatabaseName)
    //         .doc(Singleton.instance.agentRef)
    //         .collection(Constants.firebaseCase)
    //         .doc(caseId)
    //         .snapshots()
    //         .forEach((element) {
    //       element.data()!.forEach((key, value) {
    //         if (key == 'addressDetails') {
    //           Map selectedAddress = bloc.selectedAddressModel;
    //           value.asMap().forEach((index, values) {
    //             Map addressModel = Map.from(values);
    //             if (selectedAddress['value'] == addressModel['value']) {
    //               indexNumber = index;
    //               debugPrint(indexNumber.toString());
    //             } else {
    //               toUpdateValues.add(addressModel);
    //             }
    //           });
    //         }
    //       });
    //     });

    //     debugPrint('values--> ${bloc.selectedAddressModel}');
    //     debugPrint('toUpdateValues--> $toUpdateValues');
    //     FirebaseFirestore.instance
    //         .collection(Singleton.instance.firebaseDatabaseName)
    //         .doc(Singleton.instance.agentRef)
    //         .collection(Constants.firebaseCase)
    //         .doc(caseId)
    //         .update(
    //           selectedFollowUpDate == null
    //               ? {'collSubStatus': selectedClipValue}
    //               : {
    //                   'fieldfollowUpDate': selectedFollowUpDate,
    //                   'collSubStatus': selectedClipValue,
    //                   // 'addressDetails.$indexNumber': bloc.selectedAddressModel,
    //                   'addressDetails': toUpdateValues,
    //                 },
    //         );
    //   }
    //   returnValues = true;
    // } else {
    //   returnValues = false;
    // }
    return returnValues;
  }

  // to update the case detail starred cases or not
  static Future<bool> updateStarred({dynamic isStarred, dynamic caseId}) async {
    // ignore: prefer_final_locals
    bool returnValues = true;
    // if (Singleton.instance.usertype == Constants.fieldagent) {
    //   await FirebaseFirestore.instance
    //       .collection(Singleton.instance.firebaseDatabaseName)
    //       .doc(Singleton.instance.agentRef)
    //       .collection(Constants.firebaseCase)
    //       .doc(caseId)
    //       .update({'starredCase': isStarred});
    //   returnValues = true;
    // } else {
    //   returnValues = false;
    // }
    return returnValues;
  }

  //For offline purpose -> it'll storing inside of all event submission if files added
  static Map<String, dynamic> toPrepareFileStoringModel(List<File> files) {
    final List<Map<String, dynamic>> returnResult = [];
    // for (var element in files) {
    //   returnResult.add({
    //     'fileName': element.path.split('/').last,
    //     'base64String': base64Encode(element.readAsBytesSync()),
    //     'mimeType': lookupMimeType(element.path)
    //   });
    // }
    return {'events': returnResult};
  }
}
