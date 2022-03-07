import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/constants.dart';

import '../models/priority_case_list.dart';

class FirebaseUtils {
  static Future<List<Result>> caseDetailStream() async {
    List<Result> resultList = [];
    FirebaseFirestore.instance
        .collection(Singleton.instance.firebaseDatabaseName)
        .doc('${md5.convert(utf8.encode('${Singleton.instance.agentRef}'))}')
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
}
